# Build Stage
FROM rust AS build-stage

ADD . /usr/src/assignment_one
WORKDIR /usr/src/myapp

RUN cargo build --release

# Final Stage
FROM scratch

ARG GIT_COMMIT
ARG VERSION
LABEL REPO="https://github.com/yngtodd/assignment_one"
LABEL GIT_COMMIT=$GIT_COMMIT
LABEL VERSION=$VERSION

WORKDIR /usr/local/bin

COPY --from=build-stage /usr/src/assignment_one/bin/assignment_one /opt/assignment_one/bin/
RUN chmod +x /usr/local/bin/assignment_one

CMD /usr/local/bin/assignment_one
