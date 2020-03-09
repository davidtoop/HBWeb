 RUN
⍝Copy Dyalog Workspaces
 ⎕CY'/raid/home/david/Dropbox/projects/MiServer/miserver'
 'InitCauseway'⎕CY'sharpplot'
 'days date'⎕CY'dfns'


 1 InitCauseway ⍬
 ⎕SE.SALT.Load'/raid/www/HBWeb/Code/BuildConfig.dyalog'
 #.Config←BuildConfig
 Start'/raid/www/HBWeb' '/raid/home/david/Dropbox/projects/MiServer' ''
