## Out-of-Core Surface Reconstruction via Global TGV Minimization [[PDF]](https://polarnick239.github.io/static/papers/poliarnyi2021.pdf)

Available on [arxiv](https://arxiv.org/abs/2107.14790) and presented on [ICCV 2021](https://openaccess.thecvf.com/content/ICCV2021/html/Poliarnyi_Out-of-Core_Surface_Reconstruction_via_Global_TGV_Minimization_ICCV_2021_paper.html).

## Abstract

We present an out-of-core variational approach for surface reconstruction from a set of aligned depth maps.
Input depth maps are supposed to be reconstructed from regular photos or/and can be a representation of terrestrial LIDAR point clouds.
Our approach is based on surface reconstruction via total generalized variation minimization (TGV)
because of its strong visibility-based noise-filtering properties and GPU-friendliness.
Our main contribution is an out-of-core OpenCL-accelerated adaptation of this numerical algorithm 
which can handle arbitrarily large real-world scenes with scale diversity.

## Presentation

<a href="https://youtu.be/tgxNLJynNhw"><img src="https://raw.githubusercontent.com/PolarNick239/OOCSurfaceReconstructionPaper/master/.github/video_preview.png" alt="Presentation on ICCV 2021" width="49%"/></a> <a href="https://polarnick239.github.io/static/papers/poliarnyi2021_tgv_ooc_poster.pdf"><img src="https://raw.githubusercontent.com/PolarNick239/OOCSurfaceReconstructionPaper/master/.github/poster_preview.png" alt="Poster" width="49%"/></a> 


Citywall reconstruction results (better video [is encoded with H.265/HEVC](/anc/citywall_reconstruction.mp4?raw=true)):

https://user-images.githubusercontent.com/1218605/129604466-b31b95a6-a45a-485b-ba42-a49757184f20.mp4

## Structure of the repository:

 - [/pdf/poliarnyi2021.pdf](https://polarnick239.github.io/static/papers/poliarnyi2021.pdf) - the paper (compiled pdf)
 - [/pdf/poliarnyi2021_supp.pdf](https://polarnick239.github.io/static/papers/poliarnyi2021_supp.pdf) - the supplementary (compiled pdf)
 - [/presentation/poliarnyi2021_tgv_ooc_presentation.mp4](https://youtu.be/tgxNLJynNhw) - presentation video (with embedded subtitles)
 - [/presentation/poliarnyi2021_tgv_ooc_slides.pdf](https://polarnick239.github.io/static/papers/poliarnyi2021_tgv_ooc_slides.pdf) - presentation slides (pdf)
 - [/presentation/poliarnyi2021_tgv_ooc_poster.pdf](https://polarnick239.github.io/static/papers/poliarnyi2021_tgv_ooc_poster.pdf) - poster (pdf)
 - [/anc/citywall_reconstruction.mp4](/anc/citywall_reconstruction.mp4?raw=true) - supplementary video with Citywall dataset results (H.265/HEVC codec)
 - /anc/blocks.txt - supplementary text file with list of the Copenhagen city tiles (for easy automated downloading with Python)
 - /ms.tex - the paper source
 - /supplement.tex - the supplementary source (with the Copenhagen city results and with minor tables)
 - /images/* - images used for the final paper (downscaled to fit in size limits)
 - /images_highres/* - original images (including unused) in original high resolution

## Notes

1) How to compile main paper:

```
pdflatex ms; bibtex ms; pdflatex ms; pdflatex ms; mv ms.pdf poliarnyi2021.pdf
```

2) How to compile supplementary text:

```
pdflatex supplement; bibtex supplement; pdflatex supplement; pdflatex supplement; mv supplement.pdf poliarnyi2021_supp.pdf
```

3) How to add text to the video:

```
ffmpeg -i citywall_raw.mp4 -vf "drawtext=text='Citywall dataset':enable='between(t,0,5)': x=(w-text_w)/2: y=(h-text_h)*4/3/2: fontsize=50: fontcolor=black: box=0: boxcolor=black@0.5: boxborderw=5:" -c:a copy output1.mp4
ffmpeg -i output1.mp4 -vf "drawtext=text='Supplementary material for paper\:':enable='between(t,0,5)': x=(w-text_w)/2: y=(h-8*text_h): fontsize=32: fontcolor=black: box=0: boxcolor=black@0.5: boxborderw=5:" -c:a copy output2.mp4
ffmpeg -i output2.mp4 -vf "drawtext=text='Out-of-Core Surface Reconstruction via Global TGV Minimization.':enable='between(t,0,5)': x=(w-text_w)/2: y=(h-7*text_h): fontsize=32: fontcolor=black: box=0: boxcolor=black@0.5: boxborderw=5:" -c:a copy output3.mp4
ffmpeg -i output3.mp4 -vcodec libx265 -crf 28 citywall_reconstruction.mp4
```

4) How to send to arxiv:

4.1) Delete pdf/, axessibility.sty, readme.md, egbib.bib and ieee_fullname.bst

4.2) Pack into zip and upload
