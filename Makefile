USERNAME=wsuzume
SOURCE=Dockerfile
IMAGE=${USERNAME}/alpine-texlive:latest
CONTAINER=alpine-texlive

ifeq ($(OS),Windows_NT)
	PWD=$(CURDIR)
endif

# build container image
.PHONY: build
build: Dockerfile
	docker image build -f ${SOURCE} -t ${IMAGE} .

# pull image
.PHONY: pull
pull:
	docker pull wsuzume/alpine-texlive:latest

# create new container and login to the shell
.PHONY: shell
shell:
	docker container run -it --rm -v ${PWD}/workdir:/workdir ${IMAGE}

# clean up all stopped containers
.PHONY: clean
clean:
	docker container prune

# delete all image
.PHONY: doomsday
doomsday:
	docker image rm -f `docker image ls -q`



# sample
## target file is workdir/${XXDIR}/${XXMAIN}.tex
SAMPLEDIR=sample
SAMPLEMAIN=main
# uncomment if you want to compile with platex
#SAMPLEARG=-latex=platex
sample: workdir/sample/${SAMPLEMAIN}.tex
	docker container run -it --rm \
	-v ${PWD}/workdir:/workdir \
	-w /workdir/${SAMPLEDIR} \
	${IMAGE} \
	sh -c "mktexlsr && latexmk -C ${SAMPLEMAIN}.tex && latexmk ${SAMPLEARG} ${SAMPLEMAIN}.tex && dvipdfmx ${SAMPLEMAIN}.dvi && latexmk -c ${SAMPLEMAIN}.tex"
