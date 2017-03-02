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
extern ScmObj vk_sample_main_body_x(sample_info *ptr, ScmObj clrvals, VkSemaphore *sem);
extern ScmObj vk_sample_main_destroy(sample_info *ptr);


#define DECLARE_CLASS(cls, ctype, uppercase)    \
extern ScmClass *cls;                           \
 int uppercase ## _P(ScmObj obj);               \
ctype* uppercase ## _UNBOX(ScmObj obj);         \
ScmObj uppercase ## _BOX(ctype *ptr);

DECLARE_CLASS(VkSampleClass, sample_info, VKSAMPLE)
DECLARE_CLASS(VkClearValueClass, VkClearValue, VKCLEARVALUE)
DECLARE_CLASS(VkClearColorValueClass, VkClearColorValue, VKCLEARCOLORVALUE)
DECLARE_CLASS(VkClearDepthStencilValueClass, VkClearDepthStencilValue, VKCLEARDEPTHSTENCILVALUE)
DECLARE_CLASS(VkSemaphoreCreateInfoClass, VkSemaphoreCreateInfo, VKSEMAPHORECREATEINFO)
DECLARE_CLASS(VkSemaphoreClass, VkSemaphore, VKSEMAPHORE)
DECLARE_CLASS(VkDeviceClass, VkDevice, VKDEVICE)
DECLARE_CLASS(VkAllocationCallbacksClass, VkAllocationCallbacks, VKALLOCATIONCALLBACKS)


void Scm_Init_vk(void);

/* Epilogue */
SCM_DECL_END

void sample_main_init(struct sample_info &info);
void sample_main_1(struct sample_info &info);
void sample_main_2(struct sample_info &info,
                   VkClearValue *clear_values, VkSemaphore &imageAcquiredSemaphore);
void sample_main_destroy(struct sample_info &info);
/* int sample_main(int argc, char *argv[]); */


#endif  /* GAUCHE_VK_H */
