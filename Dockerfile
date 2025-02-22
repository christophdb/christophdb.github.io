FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    ruby \
    ruby-bundler \
    ruby-dev \
    nano \
    curl \
    build-essential \
    zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

RUN echo '# Install Ruby Gems to ~/gems' >> /root/.bashrc && \
    echo 'export GEM_HOME="$HOME/gems"' >> /root/.bashrc && \
    echo 'export PATH="$HOME/gems/bin:$PATH"' >> /root/.bashrc

ENV GEM_HOME=/root/gems
ENV PATH=/root/gems/bin:$PATH

WORKDIR /srv/jekyll

RUN ruby --version && bundle --version && gem install bundler jekyll

CMD ["irb"]
