# https://bugs.gentoo.org/877761
# https://bugs.gentoo.org/860873
# https://bugs.gentoo.org/861872
#  if [[ $PN != kismet ]] && [[ $PN != bladerf ]] && [[ $PN != gnuradio ]] && [[ $PN != trunk-recorder ]] && [[ $PN != osmo-fl2k ]]; then
#    export CFLAGS="${CFLAGS} -Werror=strict-aliasing -flto"
#    export CXXFLAGS="${CXXFLAGS} -Werror=strict-aliasing -flto"
#  fi

if [[ ${CATEGORY}/${PN} == media-video/ffmpeg ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == app-crypt/p11-kit ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == www-client/chromium ]]; then
  export MAKEOPTS="${MAKEOPTS} --shuffle=none"
fi

QA_CMP_ARGS='--quiet-nodebug'
if [[ $CATEGORY/$PN == app-crypt/hashcat ]]; then
  export ALLOW_TEST=all
fi
