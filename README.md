# `create_gh`

This is a class used to create `g` and `h` objects that have parameters(fields) and methods to perform the requested operations

## Parameters or fields

`path` - path to the data set
`data` - the data set to be used
`total` - specifies if the totals are contained on the data set
`mean` - specifies if the means are contained on the data set
`alpha` - minimum number of events

## Methods

`initialize` - to initialize field values
`check_data` - checks data availability, returns the `dataf` to be used, `totals`, `means` and `number_of_coloumns`
`get_g_limits` - to calculate parameters for the g_chart, returns the `lower_control_limit`, `t_bar` and `upper_control_limit`
`get_h_limits` - to calculate parameters for the h_chart, returns the `lower_control_limit`, `x_bar_bar` and `upper_control_limit`
`plot_g_chart` - to plot the g_chart, returns all points out of control limits
`plot_h_chart` - to plot the h_chart, returns all points out of control limits
`poisson_test` - to test for poisson distribution to which a rate ratio can be passed

## How to use

First create a `gh` object with the data or path to the data as illustrated below

```
my_new_gh = create_gh(path = "F:/Controller/simulated_data.csv");
```

You can obtain the graphs and other paramters by calling the methods on the object as below

```
my_new_gh$plot_h_chart()
```
