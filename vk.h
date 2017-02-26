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

extern ScmClass *VkClearColorValueClass;

#define VKCLEARCOLORVALUE_P(obj)      SCM_XTYPEP(obj, VkClearColorValueClass)
#define VKCLEARCOLORVALUE_UNBOX(obj)  SCM_FOREIGN_POINTER_REF(VkClearColorValue*, obj)
#define VKCLEARCOLORVALUE_BOX(ptr)    Scm_MakeForeignPointer(VkClearColorValueClass, ptr)

extern ScmClass *VkClearDepthStencilValueClass;

#define VKCLEARDEPTHSTENCILVALUE_P(obj)      SCM_XTYPEP(obj, VkClearDepthStencilValueClass)
#define VKCLEARDEPTHSTENCILVALUE_UNBOX(obj)  SCM_FOREIGN_POINTER_REF(VkClearDepthStencilValue*, obj)
#define VKCLEARDEPTHSTENCILVALUE_BOX(ptr)    Scm_MakeForeignPointer(VkClearDepthStencilValueClass, ptr)

extern ScmClass *VkSemaphoreCreateInfoClass;

#define VKSEMAPHORECREATEINFO_P(obj)      SCM_XTYPEP(obj, VkSemaphoreCreateInfoClass)
#define VKSEMAPHORECREATEINFO_UNBOX(obj)  SCM_FOREIGN_POINTER_REF(VkSemaphoreCreateInfo*, obj)
#define VKSEMAPHORECREATEINFO_BOX(ptr)    Scm_MakeForeignPointer(VkSemaphoreCreateInfoClass, ptr)

extern ScmClass *VkSemaphoreClass;

#define VKSEMAPHORE_P(obj)      SCM_XTYPEP(obj, VkSemaphoreClass)
#define VKSEMAPHORE_UNBOX(obj)  SCM_FOREIGN_POINTER_REF(VkSemaphore*, obj)
#define VKSEMAPHORE_BOX(ptr)    Scm_MakeForeignPointer(VkSemaphoreClass, ptr)

extern ScmClass *VkDeviceClass;

#define VKDEVICE_P(obj)      SCM_XTYPEP(obj, VkDeviceClass)
#define VKDEVICE_UNBOX(obj)  SCM_FOREIGN_POINTER_REF(VkDevice*, obj)
#define VKDEVICE_BOX(ptr)    Scm_MakeForeignPointer(VkDeviceClass, ptr)

extern ScmClass *VkAllocationCallbacksClass;

#define VKALLOCATIONCALLBACKS_P(obj)      SCM_XTYPEP(obj, VkAllocationCallbacksClass)
#define VKALLOCATIONCALLBACKS_UNBOX(obj)  SCM_FOREIGN_POINTER_REF(VkAllocationCallbacks*, obj)
#define VKALLOCATIONCALLBACKS_BOX(ptr)    Scm_MakeForeignPointer(VkAllocationCallbacksClass, ptr)



void Scm_Init_vk(void);

/* Epilogue */
SCM_DECL_END

void sample_main_init(struct sample_info &info);
void sample_main_1(struct sample_info &info);
void sample_main_destroy(struct sample_info &info);
/* int sample_main(int argc, char *argv[]); */


#endif  /* GAUCHE_VK_H */
