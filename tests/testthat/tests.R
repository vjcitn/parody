
test_that("box.scale computes with different parameters", {
 # Original test case
 bs = box.scale(15)
 expect_true( bs > 2.23 )
 expect_true( bs < 2.231 )
 
 # Test with different alpha values
 bs_01 = box.scale(15, alpha=0.01)
 expect_true(bs_01 > 3.12 & bs_01 < 3.14)
 
 # Test with different n values
 bs_50 = box.scale(50, alpha=0.05)
 expect_true(bs_50 > 2.2 & bs_50 < 2.22)
 
 # Test error conditions
 expect_error(box.scale(5, 0.05), "n must be greater than 10")
 expect_error(box.scale(15, 0.2), "procedure defined only for alpha = .01 or .05")
})

test_that("hamp.scale functions compute with different parameters", {
 # hamp.scale.3 original test case  
 hs = hamp.scale.3( 15, .05)
 expect_true(hs > 6.337 & hs < 6.338)
 expect_error({ hs <- hamp.scale.3( 15, .15)})
 
 # hamp.scale.3 with different alpha and n values
 hs_01 = hamp.scale.3(15, 0.01)
 expect_true(hs_01 > 11.28 & hs_01 < 11.30)
 
 hs_even = hamp.scale.3(20, 0.05) # even n
 expect_true(hs_even > 5.6 & hs_even < 5.61)
 
 hs_odd = hamp.scale.3(21, 0.05) # odd n
 expect_true(hs_odd > 5.52 & hs_odd < 5.53)
 
 # hamp.scale.4 tests
 hs4 = hamp.scale.4(15, 0.05)
 expect_true(hs4 > 6.35 & hs4 < 6.36)
 
 hs4_01 = hamp.scale.4(15, 0.01)
 expect_true(hs4_01 > 8.7 & hs4_01 < 8.73)
 
 hs4_even = hamp.scale.4(20, 0.05)
 expect_true(hs4_even > 6.02 & hs4_even < 6.03)
 
 # Test error conditions for both functions
 expect_error(hamp.scale.3(15, 0.2), "procedure only calibrated for alpha=0.01, 0.05")
 expect_error(hamp.scale.4(15, 0.2), "procedure only calibrated for alpha=0.01, 0.05")
 
 # Test warning for small n
 expect_warning(hamp.scale.3(8, 0.05), "procedure not calibrated for n < 10")
 expect_warning(hamp.scale.4(8, 0.05), "procedure not calibrated for n < 10")
})

test_that("shorth.scale computes with different parameters", {
 # Basic functionality
 ss = shorth.scale(15, 0.05)
 expect_true(ss > 4.34 & ss < 4.35)
 
 # Different alpha value
 ss_01 = shorth.scale(15, 0.01)
 expect_true(ss_01 > 5.5 & ss_01 < 5.51)
 
 # Different n value
 ss_50 = shorth.scale(50, 0.05)
 expect_true(ss_50 > 3.13 & ss_50 < 3.14)
 
 # Test error condition
 expect_error(shorth.scale(15, 0.2), "Rousseeuw scaling only defined for alpha = .05 or .01")
 
 # Test warning for extreme n values
 expect_warning(shorth.scale(5, 0.05), "rousseeuw calibration based on 10 <= n <= 2000")
 expect_warning(shorth.scale(2500, 0.05), "rousseeuw calibration based on 10 <= n <= 2000")
})

test_that("tukeyor computes with different parameters", {
 # Original test case
 expect_true(tukeyor(mtcars$mpg)[2] > 39.13)
 
 # Test with different alpha values
 tuk_05 = tukeyor(mtcars$mpg, alpha=0.05)
 expect_true(tuk_05[1] < -1.0 & tuk_05[2] > 39.1)
 
 tuk_01 = tukeyor(mtcars$mpg, alpha=0.01)
 expect_true(tuk_01[1] < -5.7 & tuk_01[2] > 43.8)
 
 # Test with different ftype
 tuk_classic = tukeyor(mtcars$mpg, ftype="classic")
 expect_true(tuk_classic[1] < -0.9 & tuk_classic[2] > 39.0)
})

test_that("calout.detect computes with all methods and parameters", {
 # Original basic tests
 expect_warning({ x <- calout.detect(mtcars$mpg) })
 expect_true(is.na(x$ind))
 expect_true(is.na(x$val))
 
 # GESD method tests (original)
 x = calout.detect(c(mtcars$mpg,1000), method="GESD")
 expect_true(x$ind == 33)
 expect_true(x$val == 1000)
 
 # GESD with different alpha
 x_gesd_01 = calout.detect(c(mtcars$mpg,1000), method="GESD", alpha=0.01)
 expect_true(x_gesd_01$ind == 33)
 expect_true(x_gesd_01$val == 1000)
 
 # boxplot method tests
 x_box = calout.detect(c(mtcars$mpg,1000), method="boxplot")
 expect_true(length(x_box$ind) >= 1)
 expect_true(1000 %in% x_box$val)
 
 x_box_01 = calout.detect(c(mtcars$mpg,1000), method="boxplot", alpha=0.01)
 expect_true(length(x_box_01$ind) >= 1)
 expect_true(1000 %in% x_box_01$val)
 
 # medmad method tests  
 x_med = calout.detect(c(mtcars$mpg,1000), method="medmad")
 expect_true(length(x_med$ind) >= 1)
 expect_true(1000 %in% x_med$val)
 
 x_med_01 = calout.detect(c(mtcars$mpg,1000), method="medmad", alpha=0.01)
 expect_true(length(x_med_01$ind) >= 1)
 expect_true(1000 %in% x_med_01$val)
 
 # shorth method tests (original)
 x = calout.detect(c(mtcars$mpg,1000), method="shorth")
 expect_true(length(x$outlier.region)==2)
 expect_true(x$outlier.region[1] < -3.351)
 expect_true(x$outlier.region[2] > 40.05)
 
 # shorth with different alpha
 x_sho_01 = calout.detect(c(mtcars$mpg,1000), method="shorth", alpha=0.01)
 expect_true(length(x_sho_01$outlier.region) == 2)
 expect_true(1000 %in% x_sho_01$val)
 
 # hybrid method tests
 scaling_func <- function(n, alpha) 2.5
 location_func <- median
 scale_func <- mad
 
 x_hyb = calout.detect(c(mtcars$mpg,1000), method="hybrid", 
                      scaling=scaling_func, location=location_func, scale=scale_func)
 expect_true(length(x_hyb$outlier.region) == 2)
 expect_true(length(x_hyb$ind) >= 1)
 
 # hybrid method error test
 expect_error(calout.detect(c(mtcars$mpg,1000), method="hybrid"), 
              "hybrid detection requires scaling, location and args")
 
 # Test with custom k parameter
 x_k = calout.detect(c(mtcars$mpg,1000), method="GESD", k=5)
 expect_true(length(x_k$ind) <= 5)
})

test_that("mv.calout.detect computes with different parameters", {
 data(bushfire)
 
 # Original test
 x = mv.calout.detect(bushfire)
 expect_true(length(x$inds) == 5)
 expect_true(x$k == 18)
 
 # Test with different k values
 x_k5 = mv.calout.detect(bushfire, k=5)
 expect_true(length(x_k5$inds) == 5)
 expect_true(x_k5$k == 5)
 
 x_k10 = mv.calout.detect(bushfire, k=10)
 expect_true(length(x_k10$inds) <= 10)
 expect_true(x_k10$k == 10)
 
 # Test with different alpha values
 x_a01 = mv.calout.detect(bushfire, alpha=0.01)
 expect_true(length(x_a01$inds) >= 1)
 expect_true(x_a01$alpha == 0.01)
 
 x_a05 = mv.calout.detect(bushfire, alpha=0.05)
 expect_true(length(x_a05$inds) >= 1)
 expect_true(x_a05$alpha == 0.05)
 
 # Test combination of parameters
 x_combo = mv.calout.detect(bushfire, k=8, alpha=0.01)
 expect_true(length(x_combo$inds) >= 1)
 expect_true(x_combo$k == 8)
 expect_true(x_combo$alpha == 0.01)
 
 # Test error for non-parametric methods
 expect_error(mv.calout.detect(bushfire, method="rocke"), 
              "only providing parametric methods now")
})

test_that("helper functions work with different parameters", {
 test_data <- mtcars$mpg
 
 # shorth function tests
 sh1 = shorth(test_data)
 expect_true(sh1$midpt.shorth > 18.0 & sh1$midpt.shorth < 19.0)
 expect_true(sh1$length.shorth > 6.0 & sh1$length.shorth < 7.0)
 expect_true(sh1$alpha == 0.5)
 
 sh2 = shorth(test_data, Alpha=0.6)
 expect_true(sh2$midpt.shorth > 17.0 & sh2$midpt.shorth < 19.0)
 expect_true(sh2$alpha == 0.6)
 
 # hampor function tests
 hamp1 = hampor(test_data, g=2.5)
 expect_true(length(hamp1) == 2)
 expect_true(hamp1[1] < hamp1[2])
 expect_true(hamp1[1] > 10.0 & hamp1[2] < 30.0)
 
 hamp2 = hampor(test_data, g=3.0)
 expect_true(length(hamp2) == 2)
 expect_true(hamp2[1] < hamp1[1]) # wider interval with larger g
 expect_true(hamp2[2] > hamp1[2])
 
 # rouor function tests (shorth-based outlier region)
 rou1 = rouor(test_data)
 expect_true(length(rou1) == 2)
 expect_true(rou1[1] < rou1[2])
 
 rou2 = rouor(test_data, alpha=0.01)
 expect_true(length(rou2) == 2)
 expect_true(rou2[1] < rou1[1]) # more conservative with smaller alpha
 expect_true(rou2[2] > rou1[2])
 
 # Test rouor error with invalid frac
 expect_error(rouor(test_data, frac=0.7), 
              "rousseeuw detection not defined for frac != .5")
})

test_that("outlier detection helper functions work", {
 test_data_with_outlier <- c(mtcars$mpg, 1000)
 
 # Test tukeyorinds function
 tuk_inds = tukeyorinds(test_data_with_outlier)
 expect_true("ind" %in% names(tuk_inds))
 expect_true("val" %in% names(tuk_inds))
 expect_true("outlier.region" %in% names(tuk_inds))
 expect_true(1000 %in% tuk_inds$val)
 
 # Test hampoutinds function  
 hamp_inds = hampoutinds(test_data_with_outlier)
 expect_true("ind" %in% names(hamp_inds))
 expect_true("val" %in% names(hamp_inds))
 expect_true("outlier.region" %in% names(hamp_inds))
 expect_true(1000 %in% hamp_inds$val)
 
 # Test rououtinds function
 rou_inds = rououtinds(test_data_with_outlier)
 expect_true("ind" %in% names(rou_inds))
 expect_true("val" %in% names(rou_inds))
 expect_true("outlier.region" %in% names(rou_inds))
 expect_true(1000 %in% rou_inds$val)
 
 # Test with data that has no outliers - should generate warnings
 normal_data = rnorm(20, mean=0, sd=1)
 expect_warning(tukeyorinds(normal_data), "no data values in outlier region")
 expect_warning(hampoutinds(normal_data), "no data values in outlier region")
 expect_warning(rououtinds(normal_data), "no data values in outlier region")
})
