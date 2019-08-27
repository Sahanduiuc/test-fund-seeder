# README

## Ruby version
2.6.3 

## Rails version
6.0.0

## Database creation
```bash
rake db:create
rake db:migrate
```

## How to run the test suite
```bash
rake test
```

## Services
```bash
rake jobs:recurrent:start  # add recurrent jobs to queue
rake jobs:work             # run jobs queue handler
rake jobs:recurrent:stop   # remove recurrent jobs from queue
```
