1. for security reasons don't hardcode the subscription deatils in provider.
   instend of use azure devops pipeline library

   need to add variable in pipeline library and declare as a - group :  and call as env in pipeline during execution
                 env:
                   ARM_CLIENT_ID: $(ARM_CLIENT_ID)
                   ARM_CLIENT_SECRET: $(ARM_CLIENT_SECRET)
                   ARM_SUBSCRIPTION_ID: $(ARM_SUBSCRIPTION_ID)
                   ARM_TENANT_ID: $(ARM_TENANT_ID)

2. need to add variable to control the bootstrap stage because it need to run only one time create a storage for backend.
   while running the pipeline again the stage 1 need to be skip 
   for this we need to create a library form bootstampcontrol = bootstrap_done(key)= false(value).

   add a condition on stage 1 to control bootstarp >>> condition: eq(variables['bootstrap_done'], 'false')   >>  if its false it execute otherwise it skip the stage.
   after the 1 st exeution of pipeline need to change the variable value to false to skip the stage 1.
   