;; Set of GNU Guix channels to use to reproduce this computational
;; experiment.  Run:
;;
;;   guix time-machine -C channels.scm -- shell -m manifest.scm --container
;;
;; to enter the environment built from this very Guix revision.

(list (channel
        (name 'guix)
        (url "https://git.savannah.gnu.org/git/guix.git")
        (branch "master")
        (commit
          "269cfe341f242c2b5f37774cb9b1e17d9aa68e2c")
        (introduction
          (make-channel-introduction
            "9edb3f66fd807b096b48283debdcddccfea34bad"
            (openpgp-fingerprint
              "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA")))))
