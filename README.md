
### Test Files
test/test_seqs.fa


### example usage:

docker run -v "$(pwd)"/test:/home/appuser -u $(id -u ${USER}):$(id -g ${USER}) -it j81docker/jpred_batch:1.1

==========================================================

### IN CONTAINER

==========================================================

INPUT: FASTA_FILE, a multisequence fasta file
OUTPUT: FASTA_DIR, a directory named after the fasta file containing single sequence fasta files
> prepareInputs.csh {FASTA_FILE}

INPUT: FASTA_DIR, created by the prepareInputs.csh
OUTPUT: results, named *.jnet and logs about each job submitted
> massSubmitScheduler.csh {FASTA_DIR}
