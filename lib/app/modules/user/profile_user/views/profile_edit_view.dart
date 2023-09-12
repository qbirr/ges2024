import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ges2024/app/modules/user/profile_user/controllers/profile_user_controller.dart';
import 'package:get/get.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:shimmer/shimmer.dart';

class ProfileEditView extends GetView<ProfileUserController> {
  const ProfileEditView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.authC.nameController.text =
        controller.authC.userData.value.namaLengkap!;
    controller.authC.namaPanggilanController.text =
        controller.authC.userData.value.namaPanggilan ?? "";
    controller.authC.emailController.text =
        controller.authC.userData.value.email!;
    controller.authC.phoneController.text =
        controller.authC.userData.value.noHp!;
    final formKey = GlobalKey<FormState>();
    return WillPopScope(
      onWillPop: () {
        controller.authC.clear();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profil'),
          leading: IconButton(
            onPressed: () {
              controller.authC.clear();
              Get.back();
            },
            icon: const Icon(Icons.close),
          ),
          actions: [
            IconButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Get.dialog(
                    AlertDialog(
                      title: const Text('Konfirmasi'),
                      content: const Text('Yakin edit profil?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text('Tidak'),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.authC.updateProfile();
                            Get.back();
                          },
                          child: const Text('Ya'),
                        ),
                      ],
                    ),
                  );
                }
              },
              icon: const Icon(Icons.check),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          GetBuilder<ProfileUserController>(
                              builder: (controller) {
                            if (controller
                                .authC.fotoController.text.isNotEmpty) {
                              return GestureDetector(
                                onTap: () => Get.bottomSheet(
                                  Stack(
                                    children: [
                                      SizedBox(
                                        // color: Colors.black,
                                        width: Get.width,
                                        height: Get.height,
                                        child: PinchZoom(
                                          maxScale: 10,
                                          child: Image.file(File(controller
                                              .authC.fotoController.text)),
                                        ),
                                      ),
                                      Positioned(
                                        right: 8,
                                        top: kToolbarHeight / 2,
                                        child: SizedBox(
                                          width: 48,
                                          height: 48,
                                          child: ElevatedButton(
                                            onPressed: () => Get.back(),
                                            style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(48.0),
                                                  ),
                                                )),
                                            child: const Icon(Icons.close),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ignoreSafeArea: true,
                                  isScrollControlled: true,
                                  isDismissible: false,
                                  enableDrag: false,
                                ),
                                child: Center(
                                  child: CircleAvatar(
                                    radius: 48,
                                    backgroundImage: FileImage(File(
                                        controller.authC.fotoController.text)),
                                  ),
                                ),
                              );
                            } else {
                              return CachedNetworkImage(
                                imageUrl:
                                    controller.authC.userData.value.foto ??
                                        "https://via.placeholder.com/150",
                                imageBuilder: (context, imageProvider) =>
                                    GestureDetector(
                                  onTap: () => Get.bottomSheet(
                                    Stack(
                                      children: [
                                        SizedBox(
                                          // color: Colors.black,
                                          width: Get.width,
                                          height: Get.height,
                                          child: PinchZoom(
                                            maxScale: 10,
                                            child: Image(image: imageProvider),
                                          ),
                                        ),
                                        Positioned(
                                          right: 8,
                                          top: kToolbarHeight / 2,
                                          child: SizedBox(
                                            width: 48,
                                            height: 48,
                                            child: ElevatedButton(
                                              onPressed: () => Get.back(),
                                              style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.zero,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(48.0),
                                                    ),
                                                  )),
                                              child: const Icon(Icons.close),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    ignoreSafeArea: true,
                                    isScrollControlled: true,
                                    isDismissible: false,
                                    enableDrag: false,
                                  ),
                                  child: Center(
                                    child: CircleAvatar(
                                      radius: 48,
                                      backgroundImage: imageProvider,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: const Center(
                                    child: CircleAvatar(
                                      radius: 48,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Center(
                                  child: CircleAvatar(
                                    radius: 48,
                                    child: Icon(Icons.error),
                                  ),
                                ),
                              );
                            }
                          }),
                          Center(
                              child: TextButton(
                                  onPressed: () {
                                    controller.pickImage();
                                  },
                                  child: const Text('Edit Foto'))),
                        ],
                      ),
                      Column(
                        children: [
                          CachedNetworkImage(
                            imageUrl: controller.authC.userData.value.fotoKtp ??
                                "https://via.placeholder.com/150",
                            imageBuilder: (context, imageProvider) =>
                                GestureDetector(
                              onTap: () => Get.bottomSheet(
                                Stack(
                                  children: [
                                    SizedBox(
                                      // color: Colors.black,
                                      width: Get.width,
                                      height: Get.height,
                                      child: PinchZoom(
                                        maxScale: 10,
                                        child: Image(image: imageProvider),
                                      ),
                                    ),
                                    Positioned(
                                      right: 8,
                                      top: kToolbarHeight / 2,
                                      child: SizedBox(
                                        width: 48,
                                        height: 48,
                                        child: ElevatedButton(
                                          onPressed: () => Get.back(),
                                          style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(48.0),
                                                ),
                                              )),
                                          child: const Icon(Icons.close),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                ignoreSafeArea: true,
                                isScrollControlled: true,
                                isDismissible: false,
                                enableDrag: false,
                              ),
                              child: Center(
                                child: Container(
                                  width: 171,
                                  height: 96,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.contain)),
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: 128,
                                height: 96,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => const Center(
                              child: CircleAvatar(
                                radius: 48,
                                child: Icon(Icons.error),
                              ),
                            ),
                          ),
                          const Center(
                              child: TextButton(
                                  onPressed: null, child: Text('Foto KTP'))),
                        ],
                      ),
                    ],
                  ),
                  const Text(
                    'Nama Lengkap',
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Nama Lengkap tidak boleh kosong';
                      }
                      return null;
                    },
                    controller: controller.authC.nameController,
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    'Nama Panggilan (Opsional)',
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    controller: controller.authC.namaPanggilanController,
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    'Email',
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email tidak boleh kosong';
                      }
                      if (!value.isEmail) {
                        return 'Email tidak valid';
                      }
                      return null;
                    },
                    controller: controller.authC.emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    'No HP',
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'No HP tidak boleh kosong';
                      }
                      if (!value.isPhoneNumber) {
                        return 'No HP tidak valid';
                      }
                      return null;
                    },
                    controller: controller.authC.phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    'NIK',
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[300],
                    ),
                    initialValue: controller.authC.userData.value.nik!,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    'Provinsi',
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[300],
                    ),
                    initialValue: controller.authC.userData.value.provinsi!,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    'Kabupaten',
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[300],
                    ),
                    initialValue: controller.authC.userData.value.kabupaten!,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    'Kecamatan',
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[300],
                    ),
                    initialValue: controller.authC.userData.value.kecamatan!,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    'Kelurahan / Desa',
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[300],
                    ),
                    initialValue: controller.authC.userData.value.kelurahan!,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'RT',
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                fillColor: Colors.grey[300],
                              ),
                              initialValue: controller.authC.userData.value.rt!,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'RW',
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                fillColor: Colors.grey[300],
                              ),
                              initialValue: controller.authC.userData.value.rw!,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    'Lorong / Jalan',
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[300],
                    ),
                    initialValue: controller.authC.userData.value.lrg!,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
