#Setup Paths
import sys
sys.path.append("clipit")
sys.path.append("/clipit")
sys.path.append("CLIP")
sys.path.append("/CLIP")
sys.path.append("diffvg")
sys.path.append("/diffvg")
sys.path.append("taming-transformers")
sys.path.append("/taming-transformers")

#Run the script

# prompts = "Darkness cannot drive out darkness. Only light can do that. #pixelart" #@param {type:"string"}
prompts = "Paperspace.com helps you do machine learning #pixelart" #@param {type:"string"}

aspect = "widescreen" #@param ["widescreen", "square"]
use_pixeldraw = True #@param {type:"boolean"}

## Simple setup
import clipit

## these are good settings for pixeldraw
clipit.reset_settings()
clipit.add_settings(prompts=prompts, aspect=aspect)

# The quality setting affects the quality of the output images
# use 'better' to raise the quality, but using better on the Free-GPU instances will cause an OOM error
# use 'draft' to lower it
clipit.add_settings(quality="normal", scale=2.5)
clipit.add_settings(use_pixeldraw=use_pixeldraw)


### YOU CAN ADD YOUR OWN CUSTOM SETTING HERE ####
# this is the example of how to run longer with less frequent display
# clipit.add_settings(iterations=500, display_every=50)
# clipit.add_settings(outputs='/outputs/pixels')


settings = clipit.apply_settings()
clipit.do_init(settings)
clipit.do_run(settings)

