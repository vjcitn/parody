FROM rocker/r2u:latest

RUN apt update 
RUN apt install -y texinfo git vim

RUN Rscript -e "install.packages(c('BiocManager', 'BiocCheck', 'rcmdcheck', 'tinytex'), update=TRUE, ask=FALSE)"
RUN Rscript -e "library(tinytex); tinytex::install_tinytex(); tinytex::tlmgr_install('courier')"
ENV PATH="$PATH:/root/.TinyTeX/bin/x86_64-linux"
