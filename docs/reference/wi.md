# Calculate warm index and cold index

Calculate warm index and cold index

## Usage

``` r
wi(x)

ci(x)
```

## Arguments

- x:

  A numeric vector

## Value

    A string vector of url links.

## References

Kira, T. 1945. A new classification of climate in eastern Asia as the
basis for agricultural geography, Hort. Inst. Kyoto Univ., Kyoto. (in
Japanese) Warmth Index (WI) and Cold Index (CI) was proposed by Kira
(1945), which is known closely related to the distribution of
vegetation. Indices can are calculated by following equations. wi = sum
(Ti - 5), where wi is Warm index, Ti (Celsius) is mean temperature of
each month in a year when Ti \> 5. Indices can are calculated by
following equations. wi = -sum (Ti - 5), where wi is Cold index, when Ti
\< 5.

## Examples

``` r
temp <- c(-7.8, -7.2, -2.4, 5.2, 11.7, 16.5, 20.5, 21.1, 15.6, 8.8, 2.0, -4.1)
wi(temp)
#> [1] 64.4
ci(temp)
#> [1] -44.5
wi <- sum(c(0, 0, 0, 0.2, 6.7, 11.5, 15.5, 16.1, 10.6, 3.8, 0, 0))
ci <- sum(c(12.8, 12.2, 7.4, 0, 0, 0, 0, 0, 0, 0, 3.0, 9.1))
```
