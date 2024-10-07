#!/bin/bash

find "$SRC_DIR"/binary-kernel-headers -name "*.rpm" -type f | while read -r rpmfile; do
  cat "$rpmfile" | rpm2archive - | tar -xvz --show-transformed-names --transform="s|usr/||" -C "$(dirname "$rpmfile")"
  rm "$rpmfile"
done

mkdir -p ${PREFIX}/${target_machine}-${ctng_vendor}-linux-gnu/sysroot
pushd ${PREFIX}/${target_machine}-${ctng_vendor}-linux-gnu/sysroot > /dev/null 2>&1
mkdir -p usr/include
cp -Rf "${SRC_DIR}"/binary-kernel-headers/include/* usr/include/
popd
