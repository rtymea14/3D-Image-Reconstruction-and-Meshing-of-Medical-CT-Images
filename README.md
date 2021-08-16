# 3D-Image-Reconstruction-and-Meshing-of-Medical-CT-Images
3D Image Reconstruction and Meshing of Medical CT Images

## Overview
A mthod to obtain 3D volume mesh from a CT scan image is presented. CT or mico-CT images are usually in DICOM or .nrrd formats. Here CT image of a human femur, [femur31.nrrd](femur31.nrrd), obtained form the 3D slicer database is used to demonstrate  the methodology. The image is first read into 3d Slicer program which allows exporting the image into other formats. A snapshot of the femur in 3d Slicer is shown.

<img src="https://github.com/rtymea14/3D-Image-Reconstruction-and-Meshing-of-Medical-CT-Images/blob/main/slicerImage.png" width="350" height="175" />

The .nrrd image is saved into a multipage .tiff image called [bones.tiff](bones.tiff). The multipage .tiff image is further converted into single .tiff [images](selected) using [ImageMagick](https://imagemagick.org/index.php). The required command is:
```
magick convert bones.tiff single%d.tiff
```
The single .tiff files are saved in the [selected](selected) folder. The reason it is called selected is because it contains the body(shaft) part of the femur. The matlab code [CT_To_Volume.m](CT_To_Volume.m) reads all the files in the [selected](selected) folder and creates a 3d volume image shown below. The slected images are cropped and binarized before turning them into voxels. The file [Conn_Filt.m](Conn_Filt.m) connects the 2d images into 3d volume. An extra file [Isolate_Trab.m](Isolate_Trab.m) is also added which allows some cleaning up of the volume image by applying "opening operation" on the images. The files are written based on the thesis work of [Zachary Lee Kohn](#References). However the codes are slightly modified to make them flexible. Also, the volume mesh generation used in the thesis work is not followed because of the way centroid elements are calculated, which intorduces some approximation. The mesh genration is also not flexible enough for different platforms. Hence a different method is used to generate the mesh.

<img src="https://github.com/rtymea14/3D-Image-Reconstruction-and-Meshing-of-Medical-CT-Images/blob/main/volview1.png" width="350" height="175" />

<img src="https://github.com/rtymea14/3D-Image-Reconstruction-and-Meshing-of-Medical-CT-Images/blob/main/volView2.png" width="350" height="175" />

To generate the volume mesh the [iso2mesh](http://iso2mesh.sourceforge.net/cgi-bin/index.cgi?Doc/README) toolbox is used. More information about the toolbox can be found in the [developers' website](http://iso2mesh.sourceforge.net/cgi-bin/index.cgi?Doc/README). The file [extraCommands.txt](extraCommands.txt) contains the commands required to install and generate the volume mesh using iso2mesh.

```
$ pathtool
$ rehash
$ which vol2mesh
$ save mydata V_conn
$ load mydata.mat
$ [node,elem,face] = v2m(V_conn,0.5,2,100);
$ plotmesh(node,face)
$ savestl(node,elem,"/home/raihan/Documents/bone.stl",bone)
```
Currently iso2mesh only allows saving to stl format. Now the stl needed to be exported to the [Meshlab](https://www.meshlab.net/) to remove any duplicate nodes or self-intersecting faces using Filters/Selection/Self Intersecting Faces (Select non Manifold Edges) to select these regions, delete them, and then use hole filling tool to generate the final surface mesh. After the clean the stl mesh looks like below.

<img src="https://github.com/rtymea14/3D-Image-Reconstruction-and-Meshing-of-Medical-CT-Images/blob/main/meshlab.PNG" width="350" height="175" />

Then the file can be opened in [Gmsh](https://gmsh.info/). The commands for generating volume mesh are follows:
```
Geometry -> Elementary entities -> Add -> New -> Volume, click on the surface to build the volume
Mesh -> 3D
```
<img src="https://github.com/rtymea14/3D-Image-Reconstruction-and-Meshing-of-Medical-CT-Images/blob/main/volmesh1.PNG" width="350" height="175" />

<img src="https://github.com/rtymea14/3D-Image-Reconstruction-and-Meshing-of-Medical-CT-Images/blob/main/volmesh2.PNG" width="350" height="175" />

## References
1.  Kohn, Z. L., 2020, "Micro-CT Image-Based Mesh Generation and Finite Element Analysis of Bone," Computational Materials Science, 131, pp. 160-169.
2.  Tran, A. P., Yan, S., and Fang, Q., 2020, "Improving model-based fNIRS analysis using mesh-based anatomical and light-transport models," Neurophotonics, 7(1), 015008.
3.  Fang, Q., and Boas, D., 2009, "Tetrahedral mesh generation from volumetric binary and gray-scale images," Proceedings of IEEE International Symposium on Biomedical Imaging (ISBI 2009), pp. 1142-1145, 2009.
