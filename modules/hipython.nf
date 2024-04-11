process HIPYTHON{

  input: 
  path deglist

  output:
  stdout

  script:
  """
  #!/usr/bin/env python3
  import pandas as pd
  
  # Input data
  # Reading the Dataset
  count_data=pd.read_table('$deglist', header = None) 
  
  print("Hi! I'm a Python process. Looks like you identified " + str(count_data.size) + " DEGs. Here's 10 of them:")
  print(count_data.sample(n=10).to_string(index=False, header=False))    
  """
}
