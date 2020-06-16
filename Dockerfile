FROM perl:5.30.3 

RUN apt-get update

# jpred script is csh
RUN apt-get install -y --no-install-recommends csh 

# perl module dependencyy
RUN cpanm HTTP::Request

RUN cpanm LWP::UserAgent

ENV HOMEDIR /home/appuser
RUN useradd --create-home appuser
WORKDIR ${HOMEDIR}

RUN wget http://www.compbio.dundee.ac.uk/jpred4/downloads/jpredMassSubmitSchedule.tar.gz

RUN tar xzf jpredMassSubmitSchedule.tar.gz && rm jpredMassSubmitSchedule.tar.gz test_seqs.fa


# add script that runs both shell scripts on a multi sequence fasta file
COPY jpred_mass.sh $HOMEDIR/jpred_mass.sh
# add modified massSumbmitScheduler.csh script, changed max jobs from 3 to 30
COPY massSubmitScheduler.csh ${HOMEDIR}/massSubmitScheduler.csh

# allow user to execute
RUN chmod a+rx \
	${HOMEDIR}/prepareInputs.csh \
	${HOMEDIR}/massSubmitScheduler.csh \
	${HOMEDIR}/jpred_mass.sh

USER appuser

ENTRYPOINT ["./jpred_mass.sh"]
