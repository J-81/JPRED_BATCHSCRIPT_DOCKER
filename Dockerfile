FROM perl:5.30.3 

RUN apt-get update

# jpred script is csh
RUN apt-get install -y --no-install-recommends csh 

# perl module dependencyy
RUN cpanm HTTP::Request

RUN cpanm LWP::UserAgent

ENV HOMEDIR /home/appuser
ENV INSTALLDIR /usr/local/jpred
RUN useradd --create-home appuser \
	&& mkdir $INSTALLDIR
WORKDIR ${INSTALLDIR}


# add script that runs both shell scripts on a multi sequence fasta file
# scripts originally obtained from http://www.compbio.dundee.ac.uk/jpred4/downloads/jpredMassSubmitSchedule.tar.gz
COPY src $INSTALLDIR
# add modified massSumbmitScheduler.csh script, changed max jobs from 3 to 30
# also modified to correct jpredapi path

# allow user to execute
RUN chmod -R a+rx ${INSTALLDIR}

RUN ln -s ${INSTALLDIR}/prepareInputs.csh \
        ${INSTALLDIR}/massSubmitScheduler.csh \
        ${INSTALLDIR}/jpred_mass.sh \
	/usr/local/bin 

USER appuser
WORKDIR ${HOMEDIR}

ENTRYPOINT ["bash"]
