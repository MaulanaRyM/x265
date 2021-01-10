#!/bin/bash
#codec by Rym
#Copyright 2021
logo(){
  toilet -f smslant -F border -w 48 "Video Converter x265" | lolcat
}
proses(){
  clear
  case $pilihan in
    1)
      cd ../storage/shared
      while [ -z "$namaFileInput" ]; do
        browse(){
          toilet -f smslant -F border "select video" | lolcat
          pwd -P
          tree -L 1
          echo "\n    [1] = open folder"
          echo "    [2] = select file"
          echo "    [3] = back to main menu\n"
          printf "  Pilih: "
          read exp
          if [ $exp -eq 1 ]; then
            echo "\n  * Tanpa Tanda Petik"
            echo "  .. untuk keluar folder"
            printf "\n  Nama Folder : "
            read namaFolder
            cd "$namaFolder"
            clear
          elif [ $exp -eq 2 ]; then
            echo "\n  * Tanpa Tanda Petik"
            printf "  Nama File          : "
            read namaFileInput
            printf "  Simpan Dengan Nama : "
            read namaFileOutput
            clear
            konfirmasi(){
              toilet -f smslant -F border "Maulana Rym" | lolcat
              ptInput="$namaFileInput"
              ptOutput="$namaFileOutput"
              durasi=$(ffprobe -i "$namaFileInput" -show_entries format=duration -v quiet -of csv='p=0' -sexagesimal | sed -E 's/(:[0-9]+)\.[0-9]+/\1/g')
              echo "  Input  : $ptInput"
              echo "  Output : $ptOutput"
              echo "  Durasi : $durasi\n"
              echo "  Apakah Anda Ingin Memotong Videonya?"
              echo "    [1] Iya, potong video dulu"
              echo "    [2] Ga dulu, langsung convert aja"
              echo "    [3] Batal"
              printf "\n  Pilih : "
              read exp2
              if [ $exp2 -eq 2 ]; then
                clear
                echo "Proses Convert Akan Segera Dimulai..."
                echo "Tekan Ctrl + C untuk membatalkan proses convert"
                sleep 3
                ffmpeg -i "$namaFileInput" -c:v libx265 -crf 25 -preset ultrafast -c:a copy "$namaFileOutput"
                cd ~
                unset pilihan
                unset exp
                unset exp2
                unset exp3
                unset waktuMulai
                unset waktuSelesai
                unset namaFileInput
                unset namaFileOutput
                unset namaFolder
                clear
                echo "Proses Convert Selesai"
                exit
              elif [ $exp2 -eq 3 ]; then
                clear
                unset exp
                unset exp2
                unset namaFileInput
                unset namaFileOutput
                unset namaFolder
                browse
              elif [ $exp2 -eq 1 ]; then
                clear
                trim(){
                  toilet -f smslant -F border "Rym" | lolcat
                  ptInput="$namaFileInput"
                  ptOutput="$namaFileOutput"
                  # durasi=$(ffprobe -i "$namaFileInput" -show_entries format=duration -v quiet -of csv='p=0' -sexagesimal | sed -E 's/(:[0-9]+)\.[0-9]+/\1/g')
                  echo "  Input  : $ptInput"
                  echo "  Output : $ptOutput"
                  echo "  Durasi : $durasi\n"
                  echo "  Isi dengan format 'jam:menit:detik'"
                  echo "  Contoh : 00:01:25\n"
                  printf "  Waktu mulai video   : "
                  read waktuMulai
                  printf "  Waktu selesai video : "
                  read waktuSelesai
                  printf "\n  Mulai convert? (y/n) : "
                  read exp3
                  if [ "$exp3" = "y" ]; then
                    clear
                    echo "Proses Convert Akan Segera Dimulai..."
                    echo "Tekan Ctrl + C untuk membatalkan proses convert"
                    sleep 3
                    ffmpeg -i "$namaFileInput" -ss "$waktuMulai" -to "$waktuSelesai" -c:v libx265 -crf 25 -preset ultrafast -c:a copy "$namaFileOutput"
                    cd ~
                    unset pilihan
                    unset exp
                    unset exp2
                    unset exp3
                    unset waktuMulai
                    unset waktuSelesai
                    unset namaFileInput
                    unset namaFileOutput
                    unset namaFolder
                    clear
                    echo "Proses Convert Selesai"
                    exit 
                  elif [ "$exp3" = "n" ]; then
                    clear
                    konfirmasi
                    echo "Input Tidak Valid"
                    trim
                  fi
                }
              trim
            else
              clear
              echo "Input Tidak Valid"
              konfirmasi
              fi
            }
          konfirmasi
        elif [ $exp -eq 3 ]; then
          cd ~/uvc
          clear
          unset pilihan
          unset exp
          unset exp2
          unset exp3
          unset waktuMulai
          unset waktuSelesai
          unset namaFileInput
          unset namaFileOutput
          unset namaFolder
          menu
        else
          clear
          echo "Input Tidak Valid"
          fi
        }
      browse
    done
    ;;
  2)
    clear
    cd ~/uvc
    unset pilihan
    unset exp
    unset exp2
    unset exp3
    unset waktuMulai
    unset waktuSelesai
    unset namaFileInput
    unset namaFileOutput
    unset namaFolder
    echo "Script Berhasil Ditutup"
    exit
    ;;
  *)
    cd ~/uvc
    clear
    echo "Input Tidak Valid!"
    menu
    ;;
esac
}
menu(){
  logo
  printf "  Menu: \n"
  printf "    [1] = Pilih video\n"
  printf "    [2] = Keluar\n\n"
  printf "  Pilih: "
  read pilihan
  proses
}
clear
menu
