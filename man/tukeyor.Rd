\name{tukeyor}
\alias{tukeyor}
\alias{al}
\alias{ckesd}
\alias{gesdri}
\alias{hampoutinds}
\alias{lamtab}
\alias{logit}
\alias{rououtinds}
\alias{tukeyorinds}
\alias{skesd}
% [1] "al"             "box.scale"      "calout.detect"  "ckesd"         
% [5] "gesdri"         "hamp.scale.3"   "hamp.scale.4"   "hampor"        
% [9] "hampoutinds"    "lamtab"         "logit"          "prompt.default"
%[13] "rouor"          "rououtinds"     "shorth"         "shorth.scale"  
%[17] "skesd"          "tukeyor"        "tukeyorinds"   
\alias{rouor}
\alias{hampor}
\title{calibrated outlier region based on various algorithms  }
\description{calibrated outlier region based on various algorithms  }
\usage{
tukeyor(x, alpha=0.05, g=box.scale(length(x), alpha = alpha), ftype="ideal")
}
\arguments{
  \item{x}{ x}
  \item{alpha}{ alpha}
  \item{g}{ g}
  \item{ftype}{ ftype}
}
\author{Vince Carey <stvjc@channing.harvard.edu>}
\examples{
data(tcost)
apply(tcost, 2, tukeyor)
}
\keyword{ models }

