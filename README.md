





Install Process:

1) register all subscriptions
dare-sm subscribe <directory>

2) Install all the subscriptions
dare-sm install all
 
3) Start the subscriptions
dare-sm install-start all

Upgrade Process
1) Stop services if needed
dare-sm install-stop all

2) Upgrade
dare-sm upgrade all

3) Start subscriptions
dare-sm install-start all


System Boot

1) from init.d
dare-sm start
    - calls all subscriptions start
     
System Shutdown
1) from init.d
dare-sm stop
    - calls all subscriptions stop
    
