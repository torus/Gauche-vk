/*
 * vk.c
 */

#include "vk.h"

/*
 * The following function is a dummy one; replace it for
 * your C function definitions.
 */

/* ScmObj test_vk(void) */
/* { */
/*     return SCM_MAKE_STR("vk is working"); */
/* } */

ScmClass *VkSampleClass;
ScmClass *VkClearValueClass;
ScmClass *VkClearColorValueClass;
ScmClass *VkClearDepthStencilValueClass;
ScmClass *VkSemaphoreCreateInfoClass;
ScmClass *VkSemaphoreClass;
ScmClass *VkDeviceClass;
ScmClass *VkAllocationCallbacksClass;

ScmObj aho_aho(ScmObj a, ScmObj b)
{
  return SCM_LIST2(a, b);
}

ScmObj vk_sample_main(void)
{
    /* VkResult U_ASSERT_ONLY res; */
    struct sample_info info = {};

    // process_command_line_args(info, argc, argv);

    sample_main_init(info);

    /* VULKAN_KEY_START */
    sample_main_1(info);

    sample_main_destroy(info);
    /* sample_main(0, NULL); */
    return SCM_NIL;
}

ScmObj vk_sample_main_init(sample_info *ptr)
{
    sample_main_init(*ptr);
    return SCM_NIL;
}

ScmObj vk_sample_main_body(sample_info *ptr)
{
    sample_main_1(*ptr);
    return SCM_NIL;
}

ScmObj vk_sample_main_body_x(sample_info *ptr, ScmObj clrvals, VkSemaphore *sem)
{
    int len = Scm_Length(clrvals); /* Should be 2 */
    VkClearValue *vals = SCM_NEW_ARRAY(VkClearValue, len);
    ScmObj lis = clrvals;

    for (int i = 0; i < len; i ++) {
        VkClearValue *ptr = VKCLEARVALUE_UNBOX(SCM_CAR(lis));
        memcpy(vals + i, ptr, sizeof(VkClearValue));
        lis = SCM_CDR(lis);
    }
    sample_main_2(*ptr, vals, *sem);
    return SCM_NIL;
}

ScmObj vk_sample_main_destroy(sample_info *ptr)
{
    sample_main_destroy(*ptr);
    return SCM_NIL;
}

/*
 * Module initialization function.
 */
extern void Scm_Init_vklib(ScmModule*);

#define CLASS_PROCEDURE(ctype, scmtype, uppercase, lowercase)           \
static void lowercase ## _print(ScmObj obj, ScmPort *out, ScmWriteContext *ctx) \
{                                                                       \
    ctype *q = uppercase ## _UNBOX(obj);                                \
    Scm_Printf(out, "#<" #scmtype " \"%p\">", q);                       \
}                                                                       \
                                                                        \
static void lowercase ## _cleanup(ScmObj obj)                           \
{                                                                       \
    ctype *q;                                                           \
    q = uppercase ## _UNBOX(obj);                                       \
    delete q;                                                           \
}

CLASS_PROCEDURE(sample_info, vk-sample, VKSAMPLE, vk_sample)
CLASS_PROCEDURE(VkClearValue, vk-clear-value, VKCLEARVALUE, vk_clear_value)
CLASS_PROCEDURE(VkClearColorValue, vk-clear-color-value, VKCLEARCOLORVALUE, vk_clear_color_value)
CLASS_PROCEDURE(VkClearDepthStencilValue, vk-clear-depth-stencil-value,
                VKCLEARDEPTHSTENCILVALUE, vk_clear_depth_stencil_value)
CLASS_PROCEDURE(VkSemaphoreCreateInfo, vk-semaphore-create-info,
                VKSEMAPHORECREATEINFO, vk_semaphore_create_info)
CLASS_PROCEDURE(VkSemaphore, vk-semaphore, VKSEMAPHORE, vk_semaphore)
CLASS_PROCEDURE(VkDevice, vk-device, VKDEVICE, vk_device)
CLASS_PROCEDURE(VkAllocationCallbacks, vk-allocation-callbacks,
                VKALLOCATIONCALLBACKS, vk_allocation_callbacks)



void Scm_Init_vk(void)
{
    ScmModule *mod;

    /* Register this DSO to Gauche */
    SCM_INIT_EXTENSION(vk);

    /* Create the module if it doesn't exist yet. */
    mod = SCM_MODULE(SCM_FIND_MODULE("vk", TRUE));

    VkSampleClass =
        Scm_MakeForeignPointerClass(mod, "<vk-sample>",
                                    vk_sample_print,
                                    vk_sample_cleanup,
                                    SCM_FOREIGN_POINTER_KEEP_IDENTITY|SCM_FOREIGN_POINTER_MAP_NULL);

    VkClearValueClass =
        Scm_MakeForeignPointerClass(mod, "<vk-clear-value>",
                                    vk_clear_value_print,
                                    vk_clear_value_cleanup,
                                    SCM_FOREIGN_POINTER_KEEP_IDENTITY|SCM_FOREIGN_POINTER_MAP_NULL);

    VkClearColorValueClass =
        Scm_MakeForeignPointerClass(mod, "<vk-clear-color-value>",
                                    vk_clear_color_value_print,
                                    vk_clear_color_value_cleanup,
                                    SCM_FOREIGN_POINTER_KEEP_IDENTITY|SCM_FOREIGN_POINTER_MAP_NULL);

    VkClearDepthStencilValueClass =
        Scm_MakeForeignPointerClass(mod, "<vk-clear-depth-stencil-value>",
                                    vk_clear_depth_stencil_value_print,
                                    vk_clear_depth_stencil_value_cleanup,
                                    SCM_FOREIGN_POINTER_KEEP_IDENTITY|SCM_FOREIGN_POINTER_MAP_NULL);

    VkSemaphoreCreateInfoClass =
        Scm_MakeForeignPointerClass(mod, "<vk-semaphore-create-info>",
                                    vk_semaphore_create_info_print,
                                    vk_semaphore_create_info_cleanup,
                                    SCM_FOREIGN_POINTER_KEEP_IDENTITY|SCM_FOREIGN_POINTER_MAP_NULL);

    VkSemaphoreClass =
        Scm_MakeForeignPointerClass(mod, "<vk-semaphore>",
                                    vk_semaphore_print,
                                    vk_semaphore_cleanup,
                                    SCM_FOREIGN_POINTER_KEEP_IDENTITY|SCM_FOREIGN_POINTER_MAP_NULL);

    VkDeviceClass =
        Scm_MakeForeignPointerClass(mod, "<vk-device>",
                                    vk_device_print,
                                    vk_device_cleanup,
                                    SCM_FOREIGN_POINTER_KEEP_IDENTITY|SCM_FOREIGN_POINTER_MAP_NULL);

    VkAllocationCallbacksClass =
        Scm_MakeForeignPointerClass(mod, "<vk-allocation-callbacks>",
                                    vk_allocation_callbacks_print,
                                    vk_allocation_callbacks_cleanup,
                                    SCM_FOREIGN_POINTER_KEEP_IDENTITY|SCM_FOREIGN_POINTER_MAP_NULL);

    /* Register stub-generated procedures */
    Scm_Init_vklib(mod);

}
