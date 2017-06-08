# Dockerfile to build bcl2fastq2 container images
# Based on CentOS images made by fatherlinux
# http://developerblog.redhat.com/2014/05/15/practical-introduction-to-docker-containers/
# Fork from version by Andrew Perry <Andrew.Perry@monash.edu>, forked in turn from Cyril Firmo <firmo@biologie.ens.fr>
#
# Build:
# docker build -t bcl2fastq:2.19.0.316 -t bcl2fastq:2.19 -t bcl2fastq:latest .
#
# Run in container as root:
# docker run -it -v $(pwd):/output -v /data/illumina/my_run/:/run bcl2fastq  /usr/local/bin/bcl2fastq -o /output -R /run
#
# Notes: 
# 1. Can run in container as specific user with "--user `id -n -u`:`id -n -g`"
# 2. Append additional arguments to bcl2fastq2 at the end of the command string.
# 3. Input folder should have the expected files (SampleSheet, etc).
#

# Set the base image to CentOS 6
FROM centos:6

# File Author / Maintainer
MAINTAINER Erron Titus <erron.titus@ucsf.edu>

# Download and install wget, unzip, then bcl2fastq
RUN (yum -y --nogpgcheck install wget unzip && \
     cd /tmp && \
     wget https://support.illumina.com/content/dam/illumina-support/documents/downloads/software/bcl2fastq/bcl2fastq2-v2.19.0.316-Linux-x86_64.rpm && \
     yum -y --nogpgcheck localinstall /tmp/bcl2fastq2-*.rpm && \
     yum -y erase wget unzip && \
     yum -y clean all && \
     rm -rf /tmp/bcl2fastq*)