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

static void vk_sample_print(ScmObj obj, ScmPort *out, ScmWriteContext *ctx)
{
  sample_info *q = VKSAMPLE_UNBOX(obj);
  Scm_Printf(out, "#<vk-sample \"%p\">", q);
}

static void vk_sample_cleanup(ScmObj obj)
{
  sample_info *q;
  q = VKSAMPLE_UNBOX(obj);
  delete q;
}

// VkClearValue
static void vk_clear_value_print(ScmObj obj, ScmPort *out, ScmWriteContext *ctx)
{
    VkClearValue *q = VKCLEARVALUE_UNBOX(obj);
    Scm_Printf(out, "#<vk-clear-value \"%p\">", q);
}

static void vk_clear_value_cleanup(ScmObj obj)
{
    VkClearValue *q;
    q = VKCLEARVALUE_UNBOX(obj);
    delete q;
}

// VkClearColorValue
static void vk_clear_color_value_print(ScmObj obj, ScmPort *out, ScmWriteContext *ctx)
{
    VkClearColorValue *q = VKCLEARCOLORVALUE_UNBOX(obj);
    Scm_Printf(out, "#<vk-clear-color-value \"%p\">", q);
}

static void vk_clear_color_value_cleanup(ScmObj obj)
{
    VkClearColorValue *q;
    q = VKCLEARCOLORVALUE_UNBOX(obj);
    delete q;
}

// VkClearDepthStencilValue
static void vk_clear_depth_stencil_value_print(ScmObj obj, ScmPort *out, ScmWriteContext *ctx)
{
    VkClearDepthStencilValue *q = VKCLEARDEPTHSTENCILVALUE_UNBOX(obj);
    Scm_Printf(out, "#<vk-clear-depth-stencil-value \"%p\">", q);
}

static void vk_clear_depth_stencil_value_cleanup(ScmObj obj)
{
    VkClearDepthStencilValue *q;
    q = VKCLEARDEPTHSTENCILVALUE_UNBOX(obj);
    delete q;
}

// VkSemaphoreCreateInfo

static void vk_semaphore_create_info_print(ScmObj obj, ScmPort *out, ScmWriteContext *ctx)
{
    VkSemaphoreCreateInfo *q = VKSEMAPHORECREATEINFO_UNBOX(obj);
    Scm_Printf(out, "#<vk-semaphore-create-info \"%p\">", q);
}

static void vk_semaphore_create_info_cleanup(ScmObj obj)
{
    VkSemaphoreCreateInfo *q;
    q = VKSEMAPHORECREATEINFO_UNBOX(obj);
    delete q;
}

// VkSemaphore

static void vk_semaphore_print(ScmObj obj, ScmPort *out, ScmWriteContext *ctx)
{
    VkSemaphore *q = VKSEMAPHORE_UNBOX(obj);
    Scm_Printf(out, "#<vk-semaphore \"%p\">", q);
}

static void vk_semaphore_cleanup(ScmObj obj)
{
    VkSemaphore *q;
    q = VKSEMAPHORE_UNBOX(obj);
    delete q;
}

// VkDevice

static void vk_device_print(ScmObj obj, ScmPort *out, ScmWriteContext *ctx)
{
    VkDevice *q = VKDEVICE_UNBOX(obj);
    Scm_Printf(out, "#<vk-device \"%p\">", q);
}

static void vk_device_cleanup(ScmObj obj)
{
    VkDevice *q;
    q = VKDEVICE_UNBOX(obj);
    delete q;
}

// VkAllocationCallbacks

static void vk_allocation_callbacks_print(ScmObj obj, ScmPort *out, ScmWriteContext *ctx)
{
    VkAllocationCallbacks *q = VKALLOCATIONCALLBACKS_UNBOX(obj);
    Scm_Printf(out, "#<vk-allocation-callbacks \"%p\">", q);
}

static void vk_allocation_callbacks_cleanup(ScmObj obj)
{
    VkAllocationCallbacks *q;
    q = VKALLOCATIONCALLBACKS_UNBOX(obj);
    delete q;
}



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
