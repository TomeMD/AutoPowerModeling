# Automated approach for CPU power modeling



This repository acts as an umbrella project for different subprojects that can be combined to automatically build CPU power consumption models. The repository includes (1) [CPUPowerWatcher](https://github.com/TomeMD/CPUPowerWatcher), which gathers CPU metrics during the execution of user-configurable workloads; and (2) [CPUPowerSeer](https://github.com/TomeMD/CPUPowerSeer), which builds models to predict CPU power consumption from different CPU variables using time series data. 

Run CPUPowerWatcher on the target CPU to obtain training and test datasets along with their timestamps. Then, run CPUPowerSeer toautomatically create the models  from time series data stored in InfluxDB.

## About

This project has been developed in the Computer Architecture Group at the University of A Coruña by Tomé Maseda ([tome.maseda@udc.es](mailto:tome.maseda@udc.es)), Jonatan Enes, Roberto R. Expósito and Juan Touriño.