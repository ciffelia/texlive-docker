SOURCE=Dockerfile
IMAGE=texlive:latest
CONTAINER=texlive

# build container image
.PHONY: image
image: Dockerfile
	docker image build -f ${SOURCE} -t ${IMAGE} .

# create new container and login to the shell
.PHONY: shell
shell:
	docker container run -it --rm -v ${PWD}/workspace:/workspace ${IMAGE}

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
SAMPLEMAIN=template
sample: workdir/sample/${SAMPLEMAIN}.tex
	docker container run -it --rm \
	-v ${PWD}/workdir:/workdir \
	-w /workdir/${SAMPLEDIR} \
	${IMAGE} \
	sh -c "latexmk -C ${SAMPLEMAIN}.tex && latexmk ${SAMPLEMAIN}.tex && dvipdfmx ${SAMPLEMAIN}.dvi && latexmk -c ${SAMPLEMAIN}.tex"
