# Automated approach for CPU power modeling

This repository acts as an umbrella project for different subprojects that can be combined to automatically build CPU power consumption models. The repository includes (1) [CPUPowerWatcher](https://github.com/TomeMD/CPUPowerWatcher), which gathers CPU metrics during the execution of user-configurable workloads; and (2) [CPUPowerSeer](https://github.com/TomeMD/CPUPowerSeer), which builds models to predict CPU power consumption from different CPU variables using time series data.


## Initialization
Run `init_submodules.sh` to automatically pull and install CPUPowerWatcher and CPUPowerSeer.

## Instructions

First, run CPUPowerWatcher on the target CPU to obtain training and test datasets along with their timestamps. This tool will send the collected metrics to a time series database using InfluxDB. You can send the data to the default InfluxDB server (`montoxo.des.udc.es`) in the default bucket (`public`). Please note that your data will be deleted 30 days after storage. If you want to use your own InfluxDB server, please deploy it using the following [Docker/Apptainer image](https://github.com/TomeMD/CPUCollector/tree/master/influxdb) and remember to specify the corresponding configuration options to CPUPowerWatcher (i.e., `-i <your-influxdb-server> -b <your-influxdb-bucket>`).

Then, run CPUPowerSeer using training and test timestamps to automatically create the models from time series data stored in InfluxDB. Note that:

- Timestamps will be stored by CPUPowerWatcher in the specified directory (`-o option`). You should run this tool at least twice, once to generate the training dataset and once for the test dataset.

- Several training datasets can be used to train the same model. To do this, copy their corresponding timestamps into a single file and pass it to CPUPowerSeer (`-t option`).

- You can evaluate models with several test datasets, CPUPowerSeer supports lists of files (`-a option`).
- If you used your own InfluxDB server while running CPUPowerWatcher, remember to specify the corresponding configuration options to CPUPowerSeer, that is, specify your InfluxDB server, organization and token at `CPUPowerSeer/cpu_power_seer/influxdb/influxdb_env.py` and indicate your bucket using `-b <your-bucket>` .


## About

This project has been developed in the Computer Architecture Group at the University of A Coruña by Tomé Maseda ([tome.maseda@udc.es](mailto:tome.maseda@udc.es)), Jonatan Enes, Roberto R. Expósito and Juan Touriño.