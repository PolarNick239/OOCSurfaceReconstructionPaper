#!/bin/bash

#This script will merge two jpg images into one using imageMagick.
#The final result will be a picture that is split diagonally.
#The diagonal line will start from the bottom left of the image.
#Both pictures must be of the same size.
#If you do not give the filenames as part of the command line, the default names will be used (Left.jpg and Right.jpg).

#If command line argument 1 is not provided, the value will default to the variable $LEFT_DEFAULT
LEFT_DEFAULT="Left.jpg";
LEFT=${1:-$LEFT_DEFAULT};

#If command line argument 2 is not provided, the value will default to the variable $Right_DEFAULT
RIGHT_DEFAULT="Right.jpg";
RIGHT=${2:-$RIGHT_DEFAULT};

#The intermediate images we will use must be png to support transparency.
#We remove the extension '.jpg' from the filenames and add the extension '.png'.
LEFT_OUT="${LEFT%.jpg}.Diagonal Up - Mask.png";
RIGHT_OUT="${RIGHT%.jpg}.Diagonal Up - Mask.png";
OUT="Diagonal Up - Mask.jpg";

#Read the width of one of the images;
WIDTH=`identify -format %w "$LEFT"`;
#Read the height of one of the images;
HEIGHT=`identify -format %h "$LEFT"`;

convert -respect-parenthesis \
\( "$LEFT" -gravity north -crop "$WIDTH"x"$HEIGHT"+0+0 +repage -write "$LEFT_OUT" \) `#Load first image to a new png` \
\( "$RIGHT" -gravity east -crop "$WIDTH"x"$HEIGHT"+0+0 +repage -write "$RIGHT_OUT" \) `#Load second image to a new png` \
\( -size "$WIDTH"x"$HEIGHT" xc:black -fill white -draw "polygon 0,0 0,"$HEIGHT" "$WIDTH",0" -write "MASK_$LEFT_OUT" \) `#Create the mask of the upper triangle` \
\( -clone 2 -negate -write "MASK_$RIGHT_OUT" \) `#Create the mask of the lower triangle` \
\( -clone 0 -clone 2 -alpha off -compose copy_opacity -composite -write "$LEFT_OUT" \) `#Apply the upper triangle mask to the left image` \
\( -clone 1 -clone 3 -alpha off -compose copy_opacity -composite -write "$RIGHT_OUT" \) `#Apply the lower triangle mask to the right image` \
-delete 0-3 -compose over -composite "$OUT" `#Merge the two images together`;

#Cleaning up
rm "MASK_$RIGHT_OUT" "MASK_$LEFT_OUT" "$LEFT_OUT" "$RIGHT_OUT";

