;; GNU Guix manifest to set up the execution environment of this
;; computational experiment.  Run:
;;
;;   guix shell -m manifest.scm --container
;;
;; Using '--container' ensures there is no interference with the host system.

(use-modules (guix)
             (guix build-system python)
             (guix build-system pyproject)
             ((guix licenses) #:prefix license:)
             (gnu packages check)
             (gnu packages python-science)
             (gnu packages python-xyz)
             (gnu packages python-web)
             (gnu packages sphinx))

(define python-mesa
  ;; Since this package is currently unavailable in Guix proper, define it
  ;; here.
  (package
    (name "python-mesa")
    (version "1.2.1")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "Mesa" version))
              (sha256
               (base32
                "01504d2bgfwsg92942k34fi7adq5n9r1fw4sn5kx0sm70jwq1628"))))
    (build-system pyproject-build-system)
    (arguments
     (list #:phases #~(modify-phases %standard-phases
                        (add-after 'unpack 'remove-cookiecutter-templates
                          (lambda _
                            (delete-file-recursively
                             "mesa/cookiecutter-mesa")))
                        (replace 'check
                          (lambda* (#:key tests? #:allow-other-keys)
                            (when tests?
                              (invoke "python" "-m" "pytest" "-k"
                                      "not test_scaffold_creates_project_dir")))))))
    (propagated-inputs (list python-click
                             python-cookiecutter
                             python-networkx
                             python-numpy
                             python-pandas
                             python-tornado
                             python-tqdm))
    (native-inputs (list python-black
                         python-coverage
                         python-pytest
                         python-pytest-cov
                         ;; python-ruff
                         python-sphinx))
    (home-page "https://github.com/projectmesa/mesa")
    (synopsis "Agent-based modeling (ABM) in Python 3+")
    (description "Agent-based modeling (ABM) in Python 3+")
    (license license:asl2.0)))

(concatenate-manifests
 (list (specifications->manifest
        '("python-wrapper"
          "jupyter"
          "python-matplotlib"
          "python-pandas"))
       (packages->manifest (list python-mesa))))
