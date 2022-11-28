import os
import tempfile
import monai
import matplotlib.pyplot as plt
import numpy as np
import torch
import cv2
import nibabel as nib
from tqdm import tqdm
from monai.apps import DecathlonDataset
from monai.config import print_config
from monai.data import DataLoader
from monai.losses import DiceLoss, DiceCELoss
from monai.metrics import DiceMetric
from monai.networks.nets import DynUNet
#from task_params import deep_supr_num, patch_size, spacing
from monai.transforms import (
    CenterSpatialCropd,
    Compose,
    LoadImaged,
    NormalizeIntensityd,
    Orientationd,
    CenterSpatialCropd,
    Spacingd,
    EnsureChannelFirstd,
    ConvertToMultiChannelBasedOnBratsClassesd,
    EnsureTyped,
    ToDeviced
)
from sklearn.utils import shuffle

def get_kernels_strides(task_id):
    """
    This function is only used for decathlon datasets with the provided patch sizes.
    When refering this method for other tasks, please ensure that the patch size for each spatial dimension should
    be divisible by the product of all strides in the corresponding dimension.
    In addition, the minimal spatial size should have at least one dimension that has twice the size of
    the product of all strides. For patch sizes that cannot find suitable strides, an error will be raised.
    """
    sizes, spacings = patch_size[task_id], spacing[task_id]
    input_size = sizes
    strides, kernels = [], []
    while True:
        spacing_ratio = [sp / min(spacings) for sp in spacings]
        stride = [
            2 if ratio <= 2 and size >= 8 else 1
            for (ratio, size) in zip(spacing_ratio, sizes)
        ]
        kernel = [3 if ratio <= 2 else 1 for ratio in spacing_ratio]
        if all(s == 1 for s in stride):
            break
        for idx, (i, j) in enumerate(zip(sizes, stride)):
            if i % j != 0:
                raise ValueError(
                    f"Patch size is not supported, please try to modify the size {input_size[idx]} in the spatial dimension {idx}."
                )
        sizes = [i / j for i, j in zip(sizes, stride)]
        spacings = [i * j for i, j in zip(spacings, stride)]
        kernels.append(kernel)
        strides.append(stride)

    strides.insert(0, len(spacings) * [1])
    kernels.append(len(spacings) * [3])
    return kernels, strides


def get_network(properties, task_id, pretrain_path, checkpoint=None):
    n_class = len(properties["labels"])
    in_channels = len(properties["modality"])
    kernels, strides = get_kernels_strides(task_id)

    net = DynUNet(
        spatial_dims=3,
        in_channels=in_channels,
        out_channels=n_class,
        kernel_size=kernels,
        strides=strides,
        upsample_kernel_size=strides[1:],
        norm_name="instance",
        deep_supervision=True,
        deep_supr_num=deep_supr_num[task_id],
    )

    if checkpoint is not None:
        pretrain_path = os.path.join(pretrain_path, checkpoint)
        if os.path.exists(pretrain_path):
            net.load_state_dict(torch.load(pretrain_path))
            print("pretrained checkpoint: {} loaded".format(pretrain_path))
        else:
            print("no pretrained checkpoint")
    return net

root_dir = os.getcwd() + '/inverted-papilloma/reg_rigid_v2/'
print (f'current dir is :{root_dir}')

image_dic = {}
label_list = []
image_list = []
for f in os.listdir(root_dir):
    if not f.endswith('.csv'):
        for subf in os.listdir(root_dir + f +'/'):
            if subf.endswith('.nii.gz'):
                subfl = subf
                if subfl.split('-')[0].endswith('seg'):
                    labels = subfl
                    label_list.append(nib.load((f'{root_dir}{f}/{labels}')).get_fdata().astype(int))

                else:
                    images = subfl
                    image_list.append(nib.load((f'{root_dir}{f}/{images}')).get_fdata().astype(int))
                #image_dic[cv2.imread(f'{root_dir}{f}/{labels}')] = cv2.imread(f'{root_dir}{f}/{images}')

# monai.config.print_config()
# set_determinism(110)

# cache_num = 38
# datasetThreads =2
# batchSize = 5
# num_epochs = 300

# device = torch.cuda.set_device('cuda:7' if torch.cuda.is_available() else 'cpu')
# print(f'current gpu is: {torch.cuda.current_device()}')

# # pre-processing:
# Data_transform = Compose(
#     [
#         LoadImaged(keys=["image","label"]),
#         EnsureChannelFirstd(keys="image"),
#         ConvertToMultiChannelBasedOnBratsClassesd(keys="label"),
#         Orientationd(keys=["image","label"], axcodes="RAS"),
#         Spacingd(
#             keys=["image","label"],
#             pixdim=(2.0,2.0,2.0),
#             mode=("bilinear","nearest"),
#         ),
#      CenterSpatialCropd(keys=["image","label"],roi_size=(80,100,100)),
#      NormalizeIntensityd(keys="image",nonzero=True,
#                          channel_wise=True),
#     ]
# )



# #seperate loaders for Training/Validation and Test sets
# trainLd = DataLoader(image_list[:25],batch_size = batchSize,shuffle=False,num_workers = datasetThreads)
# valLd = DataLoader(image_list[26:29],batch_size = batchSize,shuffle=False,num_workers = datasetThreads)
# testLd = DataLoader(image_list[30:],batch_size = batchSize, shuffle=False,num_workers = datasetThreads)

# #model = monai.networks.nets.ViT(in_channels=1, img_size=[128,128,128],pos_embed='conv')
