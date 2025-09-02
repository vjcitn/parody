# Parody: Parametric And Resistant Outlier DYtection

Parody is a Bioconductor R package that provides routines for univariate and multivariate outlier detection with a focus on parametric methods, but support for some methods based on resistant statistics.

**Always reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.**

## Working Effectively

### Environment Setup
- Install R and essential dependencies:
  ```bash
  sudo apt update && sudo apt install -y r-base r-base-dev
  sudo apt install -y curl libcurl4-openssl-dev libssl-dev libxml2-dev
  sudo apt install -y r-cran-testthat  # For testing
  ```
- Installation takes approximately 5-10 minutes. NEVER CANCEL during dependency installation.

### Package Development Workflow
- **Install package locally for testing:**
  ```bash
  mkdir -p /tmp/test_lib
  R CMD INSTALL . --library=/tmp/test_lib
  ```
  - Takes ~1 second. Very fast operation.
  - **IMPORTANT**: Always create the library directory first with `mkdir -p`

- **Run tests:**
  ```bash
  R --slave --no-restore -e "library(parody, lib.loc='/tmp/test_lib'); library(testthat); source('tests/testthat/tests.R')"
  ```
  - Takes ~0.7 seconds. All tests should pass.

- **Build package (without vignettes):**
  ```bash
  R CMD build --no-build-vignettes .
  ```
  - Takes ~0.2 seconds. Builds parody_1.65.2.tar.gz

- **Build package (with vignettes - requires BiocStyle):**
  ```bash
  R CMD build .
  ```
  - Will fail without BiocStyle package. Use --no-build-vignettes for development.

## Validation Scenarios

**ALWAYS run these validation scenarios after making changes to ensure functionality:**

### Basic Functionality Test
```bash
R --slave --no-restore -e "
library(parody, lib.loc='/tmp/test_lib')

# Test univariate outlier detection
test_data <- c(1:10, 100)
result <- calout.detect(test_data)
stopifnot(result\$ind == 11 && result\$val == 100)

# Test multivariate outlier detection
data(bushfire)
mv_result <- mv.calout.detect(bushfire)
stopifnot(length(mv_result\$inds) == 5 && mv_result\$k == 18)

# Test scale functions
bs_result <- box.scale(15)
stopifnot(bs_result > 2.23 && bs_result < 2.231)

print('All validation tests passed!')
"
```

### Test Suite Validation
```bash
R --slave --no-restore -e "
library(parody, lib.loc='/tmp/test_lib')
library(testthat)
source('tests/testthat/tests.R')
print('Test suite completed successfully!')
"
```

## Package Structure and Key Files

### Core R Functions (R/ directory):
- **univ.R**: Univariate outlier detection functions (`calout.detect`, scale functions)
- **mv.calout.detect.R**: Multivariate outlier detection (`mv.calout.detect`)
- **CPexchC.R**: Additional utility functions

### Data Files (data/ directory):
- **bushfire.rda**: Multivariate dataset for testing
- **tcost.rda**: Additional test dataset

### Testing:
- **tests/testthat/tests.R**: Comprehensive test suite covering all main functions
- Tests cover: `box.scale`, `hamp.scale.3`, `tukeyor`, `calout.detect`, `mv.calout.detect`
- All tests should pass in under 1 second

### Documentation:
- **man/**: R documentation files (.Rd format)
- **vignettes/parody.Rmd**: Package vignette (requires BiocStyle to build)

## Common Development Tasks

### Testing Package Changes
1. **Always reinstall after code changes:**
   ```bash
   mkdir -p /tmp/test_lib  # Create directory if it doesn't exist
   R CMD INSTALL . --library=/tmp/test_lib
   ```

2. **Run validation scenarios to ensure functionality works**

3. **Run full test suite:**
   ```bash
   R --slave --no-restore -e "library(parody, lib.loc='/tmp/test_lib'); library(testthat); source('tests/testthat/tests.R')"
   ```

**Note**: Warning messages like "GESD detection selected by default" and "shorth is not unique" are normal and expected.

### Building for Distribution
```bash
# Quick build without vignettes (for testing)
R CMD build --no-build-vignettes .

# Full build with vignettes (requires BiocStyle)
R CMD build .
```

### Working with Functions
- **Main outlier detection**: `calout.detect()` supports methods: "GESD", "boxplot", "medmad", "shorth", "hybrid"
- **Multivariate detection**: `mv.calout.detect()` for multivariate outlier detection
- **Scale functions**: `box.scale()`, `hamp.scale.3()`, `tukeyor()`

## Dependencies and Requirements

### Required:
- R (>= 3.5.0)
- tools package (auto-loaded)
- utils package (auto-loaded)

### For Testing:
- testthat package

### For Vignette Building:
- knitr
- BiocStyle
- rmarkdown

### Network Issues:
- Package works completely offline for core development
- BiocManager may show network warnings but functions correctly
- Use Ubuntu package manager (`apt install r-cran-*`) if CRAN installation fails

## CI/GitHub Actions

The repository uses `.github/workflows/basic.yml` which:
- Runs in Docker container (vjcitn/isochk:0.0.4)
- Installs dependencies with `BiocManager::install()`  
- Runs `rcmdcheck::rcmdcheck()` for package checking
- Requires pandoc for documentation building

## Troubleshooting

### Common Issues:
1. **"No package called 'testthat'"**: Install with `sudo apt install -y r-cran-testthat`
2. **Vignette build fails**: Use `R CMD build --no-build-vignettes .` for development
3. **Network timeouts**: Use Ubuntu packages (`r-cran-*`) instead of CRAN installs
4. **Permission errors**: Use `sudo` for system package installation

### Performance Notes:
- All core operations complete in under 1 second
- Package is very lightweight - no heavy computational dependencies
- Tests run quickly and comprehensively validate functionality

## Sample Output from Key Commands

### Package Installation Success:
```
* installing *source* package 'parody' ...
** using staged installation
** R
** data
** inst
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
** building package indices
** installing vignettes
** testing if installed package can be loaded from temporary location
** testing if installed package can be loaded from final location
** testing if installed package keeps a record of temporary installation path
* DONE (parody)
```

### Successful Test Run:
```
Loading required package: tools
Test passed 🎊
Test passed 🌈
Test passed 🌈
```

### Package Build Output:
```
* checking for file './DESCRIPTION' ... OK
* preparing 'parody':
* checking DESCRIPTION meta-information ... OK
* checking for LF line-endings in source and make files and shell scripts
* checking for empty or unneeded directories
* looking to see if a 'data/datalist' file should be added
* building 'parody_1.65.2.tar.gz'
```

---

**Remember**: Always install the package locally after changes, run validation scenarios, and test core functionality before committing changes. The package is designed to be fast and lightweight for rapid development iteration.