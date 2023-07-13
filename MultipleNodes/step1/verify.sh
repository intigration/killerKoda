#!/bin/bash


MANUFACTURER="SIEM"
INSTALLER="$1"

wemu() {
    qemu-system-x86_64 \
        -nographic \
        -boot menu=on \
        -enable-kvm \
        -machine accel=kvm \
        -smp cores=4 \
        -m 8G \
        -cpu kvm64,+vmx,+vme,+msr,+x2apic,+hypervisor,+aes,+vmx-activity-hlt,+vmx-cr3-load-noexit,+vmx-cr3-store-noexit,+vmx-cr8-load-exit,+vmx-cr8-store-exit,+vmx-desc-exit,+vmx-entry-ia32e-mode,+vmx-entry-load-efer,+vmx-entry-load-pat,+vmx-entry-noload-debugctl,+vmx-ept,+vmx-ept-1gb,+vmx-ept-2mb,+vmx-ept-execonly,+vmx-eptad,+vmx-exit-ack-intr,+vmx-exit-load-efer,+vmx-exit-load-pat,+vmx-exit-nosave-debugctl,+vmx-exit-save-efer,+vmx-exit-save-pat,+vmx-exit-save-preemption-timer,+vmx-flexpriority,+vmx-hlt-exit,+vmx-intr-exit,+vmx-invept,+vmx-invept-all-context,+vmx-invept-single-context,+vmx-invept-single-context,+vmx-invept-single-context-noglobals,+vmx-invlpg-exit,+vmx-invvpid,+vmx-invvpid-all-context,+vmx-invvpid-single-addr,+vmx-io-bitmap,+vmx-io-exit,+vmx-monitor-exit,+vmx-movdr-exit,+vmx-msr-bitmap,+vmx-mwait-exit,+vmx-nmi-exit,+vmx-page-walk-4,+vmx-pause-exit,+vmx-pml,+vmx-preemption-timer,+vmx-rdpmc-exit,+vmx-rdtsc-exit,+vmx-secondary-ctls,+vmx-shadow-vmcs,+vmx-store-lma,+vmx-true-ctls,+vmx-tsc-offset,+vmx-unrestricted-guest,+vmx-vintr-pending,+vmx-vmwrite-vmexit-fields,+vmx-vnmi,+vmx-vnmi-pending,+vmx-vpid,+de,+pse,+tsc,+msr,+pae,+mce,+cx8,+apic,+sep,+mtrr,+pge,+mca,+cmov,+pat,+pse36,+clflush,+mmx,+fxsr,+sse,+sse2,+ss,+ht,+syscall,+nx,+pdpe1gb,+rdtscp,+lm,+pni,+pclmulqdq,+vmx,+ssse3,+fma,+cx16,+pcid,+sse4_1,+sse4_2,+movbe,+popcnt,+aes,+xsave,+avx,+f16c,+rdrand,+hypervisor,+lahf_lm,+abm,+3dnowprefetch,+ssbd,+ibpb,+stibp,+fsgsbase,+bmi1,+avx2,+smep,+bmi2,+erms,+invpcid,+rdseed,+adx,+smap,+clflushopt,+xsaveopt,+xsavec,+xgetbv1,+xsaves \
        -bios OVMF.fd \
        -smbios type=3,manufacturer=${MANUFACTURER} \
        -boot d \
        -vnc :0 \
        -vga cirrus \
        -usb "${INSTALLER}" \
        -drive id=disk,file="${SERIAL}".qcow2,if=none \
        -device ahci,id=ahci \
        -device ide-hd,drive=disk,bus=ahci.0 \
        -watchdog ib700 \
        -device virtio-net-pci,netdev=net0 \
        -netdev user,id=net0,hostfwd=tcp::"${SSH_PORT}"-:22,hostfwd=tcp::"${DSA_PORT}"-:9005,hostfwd=tcp::"${WEB_PORT}"-:8000 \
        -smbios "type=1,family=${FAMILY}" \
        -smbios "type=0,vendor=${VENDOR},version=0version,date=0date,release=0.0,uefi=on" \
        -smbios "type=1,manufacturer=${MANUFACTURER1},product=t1product,serial=${SERIAL},uuid=${UUID},sku=t1sku,family=t1family" \
        -smbios "type=2,manufacturer=${MANUFACTURER2},product=t2product,version=t2version,serial=t2serial,asset=t2asset,location=t2location" \
        -smbios "type=3,manufacturer=${MANUFACTURER3},version=t3version,serial=t3serial,asset=t3asset,sku=t3sku" \
        -smbios "type=4,sock_pfx=t4sock_pfx,manufacturer=t4manufacturer,version=t4version,serial=t4serial,asset=t4asset,part=t4part" \
        -smbios "type=11,value=Hello,value=World" \
        -smbios "type=17,loc_pfx=t17loc_pfx,bank=t17bank,manufacturer=${MANUFACTURER},serial=t17serial,asset=t17asset,part=17part,speed=17"
        echo "hostfwd=tcp::"${SSH_PORT}"-:22,hostfwd=tcp::"${DSA_PORT}"-:9005,hostfwd=tcp::"${WEB_PORT}"-:8000"
        wait


}

wait() {

    sleep 25
    sshPass

}