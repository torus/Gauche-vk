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

ScmObj aho_aho(ScmObj a, ScmObj b)
{
  return SCM_LIST2(a, b);
}

ScmObj vk_sample_main(void)
{
  sample_main(0, NULL);
  return SCM_NIL;
}

/*
 * Module initialization function.
 */
extern void Scm_Init_vklib(ScmModule*);

void Scm_Init_vk(void)
{
    ScmModule *mod;

    /* Register this DSO to Gauche */
    SCM_INIT_EXTENSION(vk);

    /* Create the module if it doesn't exist yet. */
    mod = SCM_MODULE(SCM_FIND_MODULE("vk", TRUE));

    /* Register stub-generated procedures */
    Scm_Init_vklib(mod);

}
