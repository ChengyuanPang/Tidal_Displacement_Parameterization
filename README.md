# A parameterization of surface–interior property exchange due to internal-tide displacements in the Indonesian Seas

This project provides the source code to generate the tidal displacement parameterization and data to reproduce the figures of a paper submitted to JAMES.
The data and codes are saved in Matlab format. Full model outputs are available upon request to the corresponding author.

## Data

### `Figure_3.mat`:
 
The `lon`, `lat` and `eta_raw` is the longitude, latitude and the 1/120 degree tidal displacements, using the parameterization.

### `Figure_4.mat`:
 
`eta_10` and `eta_50` are the 1/10 degree and 1/50 degree tidal displacements, respectively.

### `Figure_5.mat`:

`lon_50`, `lat_50` and `eta_dig_50` are the longitude, latitude, and the tidal displacements diagnosed from the 1/50 degree tidal model.

### `Figure_6.mat`:

`Kv_PAR` is the increase in vertically averaged diffusivity between 80 and 150 m relative to the no-tide model, based on 1/50 degree tidal displacements.
`Kv_NT10` and `Kv_50` are the vertical diffusivity profiles for the 1/50 degree no-tide simulation and the parameterization using the 1/50 degree displacement prediction. 
`Kv_MAX`, `Kv_MEAN` and `Kv_MED` are the vertical diffusivity profiles for the 1/10 degree displacement predictions interpolated using the MEAN, MAX, and MEDIAN methods.

### `Figure_7.mat`:
`eta_MAX`, `eta_MEAN` and `eta_MED` are the predicted tidal displacements obtained using MAX, MEAN, and MEDIAN interpolation methods, respectively. 
`Kv_MAX`, `Kv_MEAN` and `Kv_MED` are the coresponding increase in vertically averaged diffusivity between 80 and 150 m relative to the 1/50 degree no-tide model.

### `Figure_8.mat`:
`SST_NT50` and `SST_T50` are the sea surface temperature of the 1/50 degree no-tide (NT50) and tide (T50) model, respectively.
`SST_NT10`, `SST_TD10`, `SST_TM10`, `SST_TD_TM10` are the sea surface temperature of the NT10, TD10, TM10, and TD&TM10 simulations.

### `Figure_9.mat`:
`Q_T50`, `Q_NT10`, `Q_TD10`, and `Q_TD_TM10`, are the air-sea heat fluxes of the NT50, NT10, TD10, and TD&TM10 simulations, respectively.

### `Figure_A1.mat`:
`EC` is the depth-integrated energy conversion from barotropic to internal tides. `kv_tide` is the vertically averaged diffusivity of tidal mixing.

## Code

### `Tidal_displacement_parameterization.m`：

`Tidal_displacement_parameterization.m` provides the code to predict the tidal displacement based on the tidal velocity and bathymetry.
### `my_interpolation`：
`my_interpolation` is the interpolation code. 
