Structure of the repository:

/anc/blocks.txt - supplementary text file with list of the Copenhagen city tiles (for easy automated downloading with Python)
/anc/citywall_reconstruction.mp4 - supplementary video with Citywall dataset results
/images_highres/* - original images (including unused) in original high resolution
/images/* - images used for the final paper (downscaled to fit in limits)
/ms.tex - the main paper
/supplement.tex - the supplementary text with the Copenhagen city results and with minor tables

1) Compile main paper:

pdflatex ms; bibtex ms; pdflatex ms; pdflatex ms; mv ms.pdf ooc_surface_reconstruction_via_global_tgv_minimization.pdf

2) Compile supplemetary text:

pdflatex supplement; bibtex supplement; pdflatex supplement; pdflatex supplement; mv supplement.pdf ooc_surface_reconstruction_via_global_tgv_minimization_supplementary.pdf

3) This was used to add text in the video:

ffmpeg -i citywall_raw.mp4 -vf "drawtext=text='Citywall dataset':enable='between(t,0,5)': x=(w-text_w)/2: y=(h-text_h)*4/3/2: fontsize=50: fontcolor=black: box=0: boxcolor=black@0.5: boxborderw=5:" -c:a copy output1.mp4
ffmpeg -i output1.mp4 -vf "drawtext=text='Supplementary material for paper\:':enable='between(t,0,5)': x=(w-text_w)/2: y=(h-8*text_h): fontsize=32: fontcolor=black: box=0: boxcolor=black@0.5: boxborderw=5:" -c:a copy output2.mp4
ffmpeg -i output2.mp4 -vf "drawtext=text='Out-of-Core Surface Reconstruction via Global TGV Minimization.':enable='between(t,0,5)': x=(w-text_w)/2: y=(h-7*text_h): fontsize=32: fontcolor=black: box=0: boxcolor=black@0.5: boxborderw=5:" -c:a copy output3.mp4
ffmpeg -i output3.mp4 -vcodec libx265 -crf 28 citywall_reconstruction.mp4

4) To send to arxiv:

4.1) Delete readme.txt, egbib.bib and ieee_fullname.bst
4.2) Pack into zip and upload
