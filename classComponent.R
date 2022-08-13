create_gh <- setRefClass(
  "shafara_gh", 
  fields = list(
    path = "character",
    data = "numeric",
    total = "logical",
    alpha = "numeric"),
  methods = list(
    initialize = function(path = "", data = c(0), total = FALSE, alpha = 3.26){
      callSuper(path = path, data = data, total = total, alpha = alpha)
    },
    check_data = function(){
      if(path == ""){
        if(data == c(0)){
          print("Error: path or data must be provided")
          return(1)
        }
      }else{
        dataf = read.csv(path, sep = ",");
      }
      
      if(total == FALSE){
        #logic to calculate
        number_of_columns = ncol(dataf)
        totals = c()
        for(value in 1:nrow(dataf)){
          totals = append(totals, sum(dataf[1:(number_of_columns)][value:value,]))
        }
      }else{
        number_of_columns = ncol(dataf)-1
        totals = dataf[, ncol(dataf)]
      }
      
      return (list(dataf, totals, number_of_columns))
    },
    get_limits = function(){
      totals = as.numeric(check_data()[[2]]);
      number_of_columns = as.numeric(check_data()[3]);
      t_bar = mean(totals);
      x_bar_bar = t_bar/number_of_columns;
      
      lower_control_limit = t_bar - 3*(sqrt(number_of_columns*(x_bar_bar - alpha)*(x_bar_bar - alpha + 1)))
      
      upper_control_limit = t_bar + 3*(sqrt(number_of_columns*(x_bar_bar - alpha)*(x_bar_bar - alpha + 1)))
      
      return(c(lower_control_limit, t_bar, upper_control_limit))
    },
    plot_graph = function(){
      
      lower_control_limit = as.numeric(get_limits()[1])
      t_bar = as.numeric(get_limits()[2])
      upper_control_limit = as.numeric(get_limits()[3])
      totals = as.numeric(check_data()[[2]]);
      
      # Extract violating points
      points_above_upper_limit = c()
      positions_of_points_above_upper_limit = c()
      for(value in 1:length(totals)){
        if(totals[value] >= upper_control_limit){
          points_above_upper_limit = append(points_above_upper_limit, totals[value])
          positions_of_points_above_upper_limit = append(positions_of_points_above_upper_limit, value)
        }
      }
      
      points_below_lower_limit = c()
      positions_of_points_below_lower_limit = c()
      for(value in 1:length(totals)){
        if(totals[value] <= upper_control_limit){
          points_below_lower_limit = append(points_below_lower_limit, totals[value])
          positions_of_points_below_lower_limit = append(positions_of_points_below_lower_limit, value)
        }
      }
      
      plot(totals, type = 'b')
      points(positions_of_points_above_upper_limit, points_above_upper_limit, col = "red")
      abline(h = c(t_bar, upper_control_limit, lower_control_limit))

      return (list(points_below_lower_limit, points_above_upper_limit))
    }))

my_new_gh = create_gh("F:/PlanMyWork/YEAR 3 SEM 2/Industrial Modelling/Coursework/Controller/geometric distibution control data.csv", total = TRUE)

my_new_gh$plot_graph()
    