/*
 * vk.h
 */

/* Prologue */
#ifndef GAUCHE_VK_H
#define GAUCHE_VK_H

#include <gauche.h>
#include <gauche/extend.h>

#ifdef __cplusplus
extern "C" {
#endif

SCM_DECL_BEGIN

/*
 * The following entry is a dummy one.
 * Replace it for your declarations.
 */

extern ScmObj test_vk(void);
extern ScmObj aho_aho(ScmObj, ScmObj);
extern ScmObj vk_sample_main(void);

int sample_main(int argc, char *argv[]);

/* Epilogue */
SCM_DECL_END

#ifdef __cplusplus
}
#endif

#endif  /* GAUCHE_VK_H */
