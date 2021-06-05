
install:
	for i in * ; do \
		test -d $$i || continue; \
		mkdir -p "${DESTDIR}"/etc/environ.d/$$i ;\
		cp -a $$i/* "${DESTDIR}"/etc/environ.d/$$i ;\
	done

