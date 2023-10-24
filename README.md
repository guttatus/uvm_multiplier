# N位移位累加乘法器及其UVM验证环境

## Simulation

``` shell
$ cd sim
$ make TESTNAME=random_data_multi_test all
$ make TESTNAME=order_data_multi_test all
$ make TESTNAME=input_always_valid_test all
```

## View waveform

``` shell
$ cd sim
$ make TESTNAME=random_data_multi_test all
$ make verdi
```

## View Coverage
``` shell
$ cd sim
$ make cov_merge
$ make imc
```
