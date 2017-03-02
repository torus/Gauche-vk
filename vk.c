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

#define CLASS_PROCEDURE(cls, ctype, scmtype, uppercase, lowercase)      \
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
}                                                                       \
int uppercase ## _P(ScmObj obj) { return SCM_XTYPEP(obj, cls); }        \
ctype* uppercase ## _UNBOX(ScmObj obj) { return SCM_FOREIGN_POINTER_REF(ctype*, obj); } \
ScmObj uppercase ## _BOX(ctype *ptr) { return Scm_MakeForeignPointer(cls, ptr); }

CLASS_PROCEDURE(VkSampleClass, sample_info, vk-sample, VKSAMPLE, vk_sample)
CLASS_PROCEDURE(VkClearValueClass, VkClearValue, vk-clear-value, VKCLEARVALUE, vk_clear_value)
CLASS_PROCEDURE(VkClearColorValueClass, VkClearColorValue,
                vk-clear-color-value, VKCLEARCOLORVALUE, vk_clear_color_value)
CLASS_PROCEDURE(VkClearDepthStencilValueClass, VkClearDepthStencilValue, vk-clear-depth-stencil-value,
                VKCLEARDEPTHSTENCILVALUE, vk_clear_depth_stencil_value)
CLASS_PROCEDURE(VkSemaphoreCreateInfoClass, VkSemaphoreCreateInfo, vk-semaphore-create-info,
                VKSEMAPHORECREATEINFO, vk_semaphore_create_info)
CLASS_PROCEDURE(VkSemaphoreClass, VkSemaphore, vk-semaphore, VKSEMAPHORE, vk_semaphore)
CLASS_PROCEDURE(VkDeviceClass, VkDevice, vk-device, VKDEVICE, vk_device)
CLASS_PROCEDURE(VkAllocationCallbacksClass, VkAllocationCallbacks, vk-allocation-callbacks,
                VKALLOCATIONCALLBACKS, vk_allocation_callbacks)

#undef CLASS_PROCEDURE


#define MAKE_CLASS(cls, scmtype, lowercase)                             \
do {                                                                    \
    cls =                                                               \
        Scm_MakeForeignPointerClass(mod, "<" #scmtype ">",              \
                                    lowercase ## _print,                \
                                    lowercase ## _cleanup,              \
                                    SCM_FOREIGN_POINTER_KEEP_IDENTITY|SCM_FOREIGN_POINTER_MAP_NULL); \
 } while (0)

void Scm_Init_vk(void)
{
    ScmModule *mod;

    /* Register this DSO to Gauche */
    SCM_INIT_EXTENSION(vk);

    /* Create the module if it doesn't exist yet. */
    mod = SCM_MODULE(SCM_FIND_MODULE("vk", TRUE));

    MAKE_CLASS(VkSampleClass, vk-sample, vk_sample);
    MAKE_CLASS(VkClearValueClass, vk-clear-value, vk_clear_value);
    MAKE_CLASS(VkClearColorValueClass, vk-clear-color-value, vk_clear_color_value);
    MAKE_CLASS(VkClearDepthStencilValueClass, vk-clear-depth-stencil-value,
               vk_clear_depth_stencil_value);
    MAKE_CLASS(VkSemaphoreCreateInfoClass, vk-semaphore-create-info, vk_semaphore_create_info);
    MAKE_CLASS(VkSemaphoreClass, vk-semaphore, vk_semaphore);
    MAKE_CLASS(VkDeviceClass, vk-device, vk_device);
    MAKE_CLASS(VkAllocationCallbacksClass, vk-allocation-callbacks, vk_allocation_callbacks);

    /* Register stub-generated procedures */
    Scm_Init_vklib(mod);

}

#undef MAKE_CLASS
