class RegisterDataDiriValidator {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama Lengkap tidak boleh kosong';
    }
    return null;
  }

  static String? validatePlaceOfBirth(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tempat Lahir tidak boleh kosong';
    }
    return null;
  }

  static String? validateDateOfBirth(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tanggal Lahir tidak boleh kosong';
    }
    return null;
  }

  static String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Jenis Kelamin tidak boleh kosong';
    }
    return null;
  }

  static String? validateProvince(String? value) {
    if (value == null || value.isEmpty) {
      return 'Provinsi tidak boleh kosong';
    }
    return null;
  }

  static String? validateRegency(String? value) {
    if (value == null || value.isEmpty) {
      return 'Kabupaten tidak boleh kosong';
    }
    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Alamat tidak boleh kosong';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nomor Telepon tidak boleh kosong';
    } else if (!RegExp(r'^\d{10,15}$').hasMatch(value)) {
      return 'Nomor Telepon tidak valid';
    }
    return null;
  }
}