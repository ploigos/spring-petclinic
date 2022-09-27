FROM registry.access.redhat.com/ubi8:8

ARG PLOIGOS_USER_UID=1001
ARG PLOIGOS_USER_GID=0
ARG PLOIGOS_HOME_DIR=/home/ploigos

USER root

# Install necessary packages
RUN dnf -y update && \
    dnf -y module enable maven:3.6 python39:3.9 && \
    dnf -y --setopt=skip_missing_names_on_install=False install \
    curl git hostname procps findutils which openssl \
    podman buildah fuse-overlayfs shadow-utils python39 \
    python39-pip maven skopeo --exclude container-selinux && \
    dnf -y reinstall shadow-utils && \
    dnf clean all && \
    rm -rf /var/cache /var/log/dnf*

# Configure ploigos user
ENV HOME=${PLOIGOS_HOME_DIR} \
WORKDIR=${PLOIGOS_HOME_DIR}
RUN useradd ploigos --uid ${PLOIGOS_USER_UID} --gid ${PLOIGOS_USER_GID} --home-dir ${PLOIGOS_HOME_DIR} --create-home --shell /sbin/nologin && \
    chown -R ${PLOIGOS_USER_UID}:${PLOIGOS_USER_GID} ${PLOIGOS_HOME_DIR} && \
    chmod -R g+w ${PLOIGOS_HOME_DIR}

# For rootless containers
RUN chmod g+w /etc/passwd && \
    touch /etc/sub{g,u}id && \
    chmod -v ug+rw /etc/sub{g,u}id

# Fix potential buildah issue with fuse
# See https://github.com/containers/buildah/blob/master/vendor/github.com/containers/storage/storage.conf
ENV _BUILDAH_STARTED_IN_USERNS="" BUILDAH_ISOLATION=chroot STORAGE_DRIVER="vfs" BUILDAH_LAYERS=true

#ADD etc/containers/containers.conf /etc/containers/

#RUN chgrp -R 0 /etc/containers/ && \
    #chmod -R a+r /etc/containers/ && \
    #chmod -R g+w /etc/containers/

# Install PSR from source
RUN pip3 install --no-cache-dir --upgrade git+https://github.com/ploigos/ploigos-step-runner.git@2.0.0-rc.3

USER ${PLOIGOS_USER_UID}

# Pause while the Jenkins agent runs
ENTRYPOINT cat

