\name{mv.calout.detect}
\alias{mv.calout.detect}
\alias{acll}
\alias{C.exch}
\alias{checksize}
\alias{checksize.rocke}
\alias{cll}
\alias{contsamp}
\alias{CPexchC}
\alias{CPunstrC}
\alias{C.unstr}
\alias{d1S}
\alias{d1s2}
\alias{exchsamp}
\alias{fig2demo}
\alias{full.sizetab}
\alias{gamg}
\alias{gamk}
\alias{gencs}
\alias{hasoutK1}
\alias{indsamp}
\alias{.initContam}
\alias{lams.exch}
\alias{lams.unstr}
\alias{mixc}
\alias{MLvarcov}
\alias{MLvarcov.di}
\alias{mv.calout.detect.exch}
\alias{p2gam}
\alias{plot.gamlist}
\alias{roctab}
\alias{s2}
\alias{sizetab}
\alias{sizetab.rocke}
\alias{standardContam}
\alias{table1}
\alias{tailqK1}
\alias{vtrace}
\alias{tcost}
\alias{NEWGAMS}
\alias{MATLIST}

%- Also NEED an `\alias' for EACH other topic documented here.
\title{ calibrated multivariate outlier detection }
\description{
interface to a parametric multivariate outlier detection algorithm
}
\usage{
mv.calout.detect(x, k=floor((nrow(x) - 1)/2), Ci=C.unstr, 
     lamfun=lams.unstr, alpha=0.05)
}
%- maybe also `usage' for other objects documented here.
\arguments{
  \item{x}{ data matrix }
  \item{k}{ upper bound on number of outliers; defaults to just
less than half the sample size }
  \item{Ci}{ function computing Ci, the covariance determinant ratio
excluding row i.  At present, sole
option is \code{C.unstr} (Caroni and
Prescott 1992 Appl Stat).}
  \item{lamfun}{ function computing lambda, the critical values for Ci }
  \item{alpha}{ false outlier labeling rate }
}
\details{
}
\value{
a list with components
  \item{inds }{indices  of outlying rows}
  \item{vals }{values of outlying rows}
  \item{k }{input parameter k }
  \item{alpha}{input parameter alpha}
}
\references{ }
\author{ VJ Carey }

\examples{
data(tcost)
mv.calout.detect(tcost)
data(bushfire)
mv.calout.detect(bushfire)
}
\keyword{ outliers }% at least one, from doc/KEYWORDS


