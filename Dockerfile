FROM openanalytics/r-base

RUN apt-get update && \
    apt-get install -y git libcurl4-openssl-dev libxml2-dev libnode-dev && \
    rm -rf /var/lib/apt/lists/* && \
    git clone --depth=1 https://github.com/plotly/dash-sample-apps /tmp/dash-sample-apps && \
    cp -r /tmp/dash-sample-apps/apps/dashr-brain-viewer /app && \
    rm -rf /tmp/dash-sample-apps

COPY Rprofile.site /usr/lib/R/etc/ # optional

RUN R -q -e "install.packages(c('remotes', 'later', 'jsonlite', 'listenv'), repos = 'http://cloud.r-project.org')"
RUN R -q -e "remotes::install_version('httpuv', version = '1.4.5.1', repos = 'http://cloud.r-project.org', upgrade='never')"
RUN R -q -e "remotes::install_version('shiny', version = '1.2.0', repos = 'http://cloud.r-project.org', upgrade='never')"
RUN R -q -e "remotes::install_version('plotly', version = '4.9.0', repos = 'http://cloud.r-project.org', upgrade='never')"
RUN R -q -e "remotes::install_version('assertthat', version = '0.2.1', repos = 'http://cloud.r-project.org', upgrade='never')"
RUN R -q -e "remotes::install_version('xml2', version = '1.2.0', repos = 'http://cloud.r-project.org', upgrade='never')"
RUN R -q -e "remotes::install_version('triebeard', version = '0.3.0', repos = 'http://cloud.r-project.org', upgrade='never')"
RUN R -q -e "remotes::install_version('urltools', version = '1.7.2', repos = 'http://cloud.r-project.org', upgrade='never')"
RUN R -q -e "remotes::install_version('webutils', version = '0.6', repos = 'http://cloud.r-project.org', upgrade='never')"
RUN R -q -e "remotes::install_version('brotli', version = '1.2', repos = 'http://cloud.r-project.org', upgrade='never')"
RUN R -q -e "remotes::install_version('jsonlite', version = '1.6', repos = 'http://cloud.r-project.org', upgrade='never')"
RUN R -q -e "remotes::install_version('reqres', version = '0.2.2', repos = 'http://cloud.r-project.org', upgrade='never')"
RUN R -q -e "remotes::install_version('uuid', version = '0.1-2', repos = 'http://cloud.r-project.org', upgrade='never')"
RUN R -q -e "remotes::install_version('base64enc', version = '0.1-3', repos = 'http://cloud.r-project.org', upgrade='never')"
RUN R -q -e "remotes::install_version('codetools', version = '0.2-16', repos = 'http://cloud.r-project.org', upgrade='never')"
RUN R -q -e "remotes::install_version('globals', version = '0.12.4', repos = 'http://cloud.r-project.org', upgrade='never')"
RUN R -q -e "remotes::install_version('future', version = '1.11.1.1', repos = 'http://cloud.r-project.org', upgrade='never')"
RUN R -q -e "remotes::install_version('routr', version = '0.3.0', repos = 'http://cloud.r-project.org', upgrade='never')"
RUN R -q -e "remotes::install_version('fiery', version = '1.1.1', repos = 'http://cloud.r-project.org', upgrade='never')"
RUN R -q -e "install.packages(c('dash'), repos = 'http://cloud.r-project.org')"
RUN R -q -e "remotes::install_github('plotly/dash-colorscales', upgrade='never')"
RUN R -q -e "install.packages(c('rapportools'), repos = 'http://cloud.r-project.org')"
RUN R -q -e "install.packages(c('rjson'), repos = 'http://cloud.r-project.org')"

EXPOSE 8050

WORKDIR /app

RUN sed -i "s#https://github.com/plotly/dash-sample-apps/tree/dashr-brain-viewer##g" app.R

ENV HOST 0.0.0.0
ENV PORT 8050

CMD Rscript app.R
