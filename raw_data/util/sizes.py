from collections import defaultdict
from gentoolkit.query import Query
import portage.versions
import os

class chrooted():
    """
    chrooted provides a context so that it can be used via with.
    For example:

    with chrooted("/some/rootfs"):
       do_operations_in_rootfs()
    do_operations_not_in_rootfs()
    """

    def __init__(self, path):
        self.path = path

    def __enter__(self):
        self.restore_fd = os.open(b"/", os.O_RDONLY)
        self.working_dir = os.getcwd()

        os.chroot(self.path)

    def __exit__(self, type, value, traceback):
        os.fchdir(self.restore_fd)
        os.chroot(b".")
        os.chdir(self.working_dir)
        os.close(self.restore_fd)

pkg_size_map = defaultdict(int)

# Setup by caller; this is pure lazyness
root = u"size_mnt"

with open("all_pkgs") as f:
    for line in f:
      inos = {} # dedupe inodes within a pkg
      pkg = portage.cpv_getkey(line)
      matches = Query(pkg).smart_find()
      for pkgv in matches:
        contents = pkgv.parsed_contents()
        for c in contents.keys():
          c = c.encode('utf-8')
          with chrooted(root):
            if not os.path.islink(c) and os.path.isfile(c):
              st = os.stat(c)
              if st.st_ino in inos:
                continue
              inos[st.st_ino] = True
              pkg_size_map[str(pkg)] += st.st_size

for k, v in pkg_size_map.iteritems():
  print str(v) + " " + str(k).strip()
