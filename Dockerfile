FROM darthjee/scripts:0.4.2 as scripts
FROM darthjee/node:0.2.0 as base

######################################

FROM base as builder

ADD source/package.json /home/node/app/

USER root
ENV MODULES_FOLDER=/usr/local/lib/node_modules
ENV HOME_DIR=/home/node
COPY --chown=node:node --from=scripts /home/scripts/builder/yarn_builder.sh /usr/local/sbin/yarn_builder.sh
RUN /bin/bash yarn_builder.sh
USER node

#######################
#FINAL IMAGE
FROM base

COPY --chown=node:node --from=builder /home/node/node_modules/ /usr/local/lib/node_modules
