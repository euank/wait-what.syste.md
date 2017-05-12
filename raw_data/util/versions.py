import portage.versions

with open("all_pkgs") as f:
  for line in f:
    v = portage.versions.cpv_getversion(str(line))
    print v.strip() + " " + line.strip()
