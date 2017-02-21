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

ScmObj aho_aho(ScmObj a, ScmObj b)
{
  return SCM_LIST2(a, b);
}

ScmObj vk_sample_main(void)
{
    VkResult U_ASSERT_ONLY res;
    struct sample_info info = {};

    // process_command_line_args(info, argc, argv);

    sample_main_init(info);

    /* VULKAN_KEY_START */
    sample_main_1(info);

    sample_main_destroy(info);
    /* sample_main(0, NULL); */
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

    /* Register stub-generated procedures */
    Scm_Init_vklib(mod);

}
