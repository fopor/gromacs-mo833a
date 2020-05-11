/*
 * This file is part of the GROMACS molecular simulation package.
 *
 * Copyright (c) 2010,2011,2012,2013,2014,2019, by the GROMACS development team, led by
 * Mark Abraham, David van der Spoel, Berk Hess, and Erik Lindahl,
 * and including many others, as listed in the AUTHORS file in the
 * top-level source directory and at http://www.gromacs.org.
 *
 * GROMACS is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public License
 * as published by the Free Software Foundation; either version 2.1
 * of the License, or (at your option) any later version.
 *
 * GROMACS is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with GROMACS; if not, see
 * http://www.gnu.org/licenses, or write to the Free Software Foundation,
 * Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA.
 *
 * If you want to redistribute modifications to GROMACS, please
 * consider that scientific software is very special. Version
 * control is crucial - bugs must be traceable. We will be happy to
 * consider code for inclusion in the official distribution, but
 * derived work must not be called official GROMACS. Details are found
 * in the README & COPYING files - if they are missing, get the
 * official version at http://www.gromacs.org.
 *
 * To help us fund GROMACS development, we humbly ask that you cite
 * the research papers on the package. Check out http://www.gromacs.org.
 */
/*! \internal \brief
 * Implements the gmx wrapper binary.
 *
 * \author Teemu Murtola <teemu.murtola@gmail.com>
 */
#include "gmxpre.h"

#include "gromacs/commandline/cmdlineinit.h"
#include "gromacs/commandline/cmdlinemodulemanager.h"
#include "gromacs/selection/selhelp.h"
#include "gromacs/trajectoryanalysis/modules.h"
#include "gromacs/utility/exceptions.h"

#include "legacymodules.h"
#include <iostream>
#include <chrono>

int main(int argc, char* argv[])
{
    printf("[ATIV-6]Application started\n");
    /* Profiling vars */
    std::chrono::duration<double> elapsed_seconds;
    std::chrono::system_clock::time_point total_start = std::chrono::system_clock::now();
    std::chrono::system_clock::time_point init_start = std::chrono::system_clock::now();

    gmx::CommandLineProgramContext& context = gmx::initForCommandLine(&argc, &argv);

    try
    {
        gmx::CommandLineModuleManager manager("gmx", &context);
        registerTrajectoryAnalysisModules(&manager);
        registerLegacyModules(&manager);
        manager.addHelpTopic(gmx::createSelectionHelpTopic());
        int rc = manager.run(argc, argv);
        gmx::finalizeForCommandLine();

        printf("[ATIV-6]Application finished\n");
        std::chrono::system_clock::time_point finish_end = std::chrono::system_clock::now();
        std::chrono::system_clock::time_point total_end = std::chrono::system_clock::now();

        elapsed_seconds = finish_end - finish_start;
        std::cout << "[ATIV-6]Total finish time: " << elapsed_seconds.count() << "s\n";

        elapsed_seconds = total_end - total_start;
        std::cout << "[ATIV-6]Total time: " << elapsed_seconds.count() << "s\n";

        return rc;
    }
    catch (const std::exception& ex)
    {
        gmx::printFatalErrorMessage(stderr, ex);
        return gmx::processExceptionAtExitForCommandLine(ex);
    }
}
