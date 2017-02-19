/*
 * vk.h
 */

/* Prologue */
#ifndef GAUCHE_VK_H
#define GAUCHE_VK_H

#include <gauche.h>
#include <gauche/extend.h>

SCM_DECL_BEGIN

/*
 * The following entry is a dummy one.
 * Replace it for your declarations.
 */

extern ScmObj test_vk(void);
extern ScmObj aho_aho(ScmObj, ScmObj);
extern ScmObj vk_sample_main(void);

void Scm_Init_vk(void);

/* Epilogue */
SCM_DECL_END

int sample_main(int argc, char *argv[]);

#endif  /* GAUCHE_VK_H */
