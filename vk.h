/*
 * vk.h
 */

/* Prologue */
#ifndef GAUCHE_VK_H
#define GAUCHE_VK_H

#include <gauche.h>
#include <gauche/extend.h>

#include <util.hpp>

SCM_DECL_BEGIN

/*
 * The following entry is a dummy one.
 * Replace it for your declarations.
 */

extern ScmObj test_vk(void);
extern ScmObj aho_aho(ScmObj, ScmObj);
extern ScmObj vk_sample_main(void);

extern ScmObj vk_sample_main_init(sample_info *ptr);
extern ScmObj vk_sample_main_body(sample_info *ptr);
extern ScmObj vk_sample_main_destroy(sample_info *ptr);


extern ScmClass *VkSampleClass;

#define VKSAMPLE_P(obj)      SCM_XTYPEP(obj, VkSampleClass)
#define VKSAMPLE_UNBOX(obj)  SCM_FOREIGN_POINTER_REF(sample_info*, obj)
#define VKSAMPLE_BOX(ptr)    Scm_MakeForeignPointer(VkSampleClass, ptr)

extern ScmClass *VkClearValueClass;

#define VKCLEARVALUE_P(obj)      SCM_XTYPEP(obj, VkClearValueClass)
#define VKCLEARVALUE_UNBOX(obj)  SCM_FOREIGN_POINTER_REF(VkClearValue*, obj)
#define VKCLEARVALUE_BOX(ptr)    Scm_MakeForeignPointer(VkClearValueClass, ptr)



void Scm_Init_vk(void);

/* Epilogue */
SCM_DECL_END

void sample_main_init(struct sample_info &info);
void sample_main_1(struct sample_info &info);
void sample_main_destroy(struct sample_info &info);
/* int sample_main(int argc, char *argv[]); */


#endif  /* GAUCHE_VK_H */
